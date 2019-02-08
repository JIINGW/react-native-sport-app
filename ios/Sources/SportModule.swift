//
//  MainApp.swift
//  Sport
//
//  Created by Fitz on 2019/2/6.
//  Copyright © 2019年 Facebook. All rights reserved.
//

import Foundation
import CoreLocation;
import CoreMotion;

func noopDispatcher(name: String, payload: Any?) -> Void {
}


public class SportModuleEvents {
    let start = "start"
    let walk = "walk"
    let activity = "activity"
    let locationAuthorizationStatusDidChange = "locationAuthorizationStatusDidChange"
    let locationHeadingUpdated = "locationHeadingUpdated"
    let locationUpdated = "locationUpdated"
    let locationWarning = "locationWarning"
}


@objc(SportModule)
class SportModule: RCTEventEmitter {

    static let events = SportModuleEvents();
  
  let motion = CMMotionManager();

    override func supportedEvents() -> [String]! {
        return [
            SportModule.events.activity,
            SportModule.events.walk,
            SportModule.events.start,
            SportModule.events.locationAuthorizationStatusDidChange,
            SportModule.events.locationHeadingUpdated,
            SportModule.events.locationUpdated,
            SportModule.events.locationWarning,
        ]
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }


    var location = LocationManager()
    var step = StepManager();
    var isActive = false;

    override init() {
        super.init();

        func dispatch(name: String, payload: Any?) {
            self.sendEvent(withName: name, body: payload);
        }

        self.location.dispatch = dispatch
        self.step.dispatch = dispatch
    }

    @objc func start(_ shouldStartStepManager: Bool) -> Void {

        if (self.isActive) {
            self.stop(true);
        }
        self.location.start();
        if (shouldStartStepManager == true) {
            self.step.start();
        }
        self.isActive = true;
    }

    @objc func stop(_ shouldStopUpdateLocation: Bool) -> Void {
        self.isActive = false;
        if (shouldStopUpdateLocation == true) {
            self.location.stop();
        }
        self.step.stop();
    }

}




