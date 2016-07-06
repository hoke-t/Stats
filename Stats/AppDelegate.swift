//
//  AppDelegate.swift
//  Stats
//
//  Created by Tanner Hoke on 7/6/16.
//  Copyright © 2016 Tanner Hoke. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem: NSStatusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) { [unowned self] in
            // do some task
            while true {
                let temp = self.getCPUTemperature()
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    // update some UI
                    self.statusItem.title = String(temp)
                }
                sleep(1)
            }
            
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func getCPUTemperature() -> Double {
        SMCOpen()
        let temperature = SMCGetTemperature(UnsafeMutablePointer<Int8>((SMC_KEY_CPU_TEMP as NSString).UTF8String))
        SMCClose()
        return temperature
    }

}

