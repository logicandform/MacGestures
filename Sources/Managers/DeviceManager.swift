//  Copyright © 2018 JABT. All rights reserved.

import Foundation
import IOKit.hid


public final class DeviceManager {
    public static let instance = DeviceManager()

    private let hidManager = IOHIDManagerCreate(kCFAllocatorDefault, 0)
    private var handlers = [DeviceHandler]()


    // MARK: Init

    private init() { }


    // MARK: API

    public func initialize() {
        // Setup
        let context = Unmanaged.passUnretained(self).toOpaque()
        IOHIDManagerRegisterDeviceMatchingCallback(hidManager, deviceDetectedCallback, context)
        IOHIDManagerRegisterDeviceRemovalCallback(hidManager, deviceRemovedCallback, context)
        IOHIDManagerScheduleWithRunLoop(hidManager, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)

        // Only listen for devices matching a product or vendor key
        let query = [kIOHIDProductIDKey: 0x1165]
        IOHIDManagerSetDeviceMatching(hidManager, query as CFDictionary)

        // Open manager
        let result = IOHIDManagerOpen(hidManager, UInt32(kIOHIDOptionsTypeSeizeDevice))
        if result != kIOReturnSuccess {
            fatalError("Could not open HIDManager.")
        }
    }

    private let deviceDetectedCallback: IOHIDDeviceCallback = { context, _, _, device in
        if let context = context {
            let manager = Unmanaged<DeviceManager>.fromOpaque(context).takeUnretainedValue()
            manager.add(device: device)
        }
    }

    private let deviceRemovedCallback: IOHIDDeviceCallback = { context, _, _, device in
        if let context = context {
            let manager = Unmanaged<DeviceManager>.fromOpaque(context).takeUnretainedValue()
            manager.remove(device: device)
        }
    }


    // MARK: Helpers

    private func add(device: IOHIDDevice) {
        let handler = DeviceHandler(device: device)
        handlers.append(handler)
    }

    private func remove(device: IOHIDDevice) {
//        handlers.removeAll(where: { $0.device == device })
    }

}
