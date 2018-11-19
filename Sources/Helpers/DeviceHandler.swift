//  Copyright © 2018 JABT. All rights reserved.

import Foundation
import IOKit.hid


final class DeviceHandler {

    private let device: IOHIDDevice
    private var touchForIndex = [Int: Int]()
    private var touchForID = [Int: Touch]()

    // MARK: Init

    init(device: IOHIDDevice) {
        self.device = device
        let context = Unmanaged.passUnretained(self).toOpaque()
        IOHIDDeviceRegisterInputValueCallback(device, valueCallback, context)
    }

    // possible usages: 48, 49, 66, 81, 84, 86,

    private let valueCallback: IOHIDValueCallback = { context, _, _, value in
        guard let context = context else {
            return
        }

        let handler = Unmanaged<DeviceHandler>.fromOpaque(context).takeUnretainedValue()
        let element = IOHIDValueGetElement(value)
        let page = IOHIDElementGetUsagePage(element)
        let usage = IOHIDElementGetUsage(element)
        let cookie = IOHIDElementGetCookie(element)
        let val = IOHIDValueGetIntegerValue(value)
        //        let scaledValue = IOHIDValueGetScaledValue(value, UInt32(kIOHIDValueScaleTypePhysical))

        if page == 13 {
            let index = Int(cookie) - 13

            if usage == 66 {
                let state = val == 1 ? "down" : "up"
                print("Touch index: \(index), state: \(state)")
                if val == 1 {
                    // down
                    if let id = handler.touchForIndex[index] {
                        let touch = Touch(state: .down, id: id, screen: 1)
                        handler.touchForID[id] = touch
                        print("Sending touch DOWN: id: \(touch.id)")
                    }
                } else {
                    // up
                    if let id = handler.touchForIndex[index], let touch = handler.touchForID[id] {
                        touch.state = .up
                        handler.touchForID.removeValue(forKey: id)
                        print("Sending touch UP: id: \(touch.id)")
                    }
                }
            } else if usage == 81 {
                print("Pointing index: \(val), to ID: \(cookie)")
                handler.touchForIndex[val] = Int(cookie)
            }
        }


        if usage == 48 {
            let index = Int((cookie - 216) / 2)
            if let id = handler.touchForIndex[index], let touch = handler.touchForID[id] {
                touch.position.x = CGFloat(IOHIDValueGetScaledValue(value, UInt32(kIOHIDValueScaleTypePhysical)))
//                print("Sending touch move-x: id: \(touch.id)")
            }
        } else if usage == 49 {
            let index = Int((cookie - 217) / 2)
            if let id = handler.touchForIndex[index], let touch = handler.touchForID[id] {
                touch.position.y = CGFloat(IOHIDValueGetScaledValue(value, UInt32(kIOHIDValueScaleTypePhysical)))
//                print("Sending touch move-y: id: \(touch.id)")
            }
        }
    }
}
