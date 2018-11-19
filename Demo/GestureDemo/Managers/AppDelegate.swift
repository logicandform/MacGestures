//  Copyright © 2018 JABT. All rights reserved.

import Cocoa
import MacGestures


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        DeviceManager.instance.initialize()
    }
}
