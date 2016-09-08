//
//  BatteryStatus.swift
//  flic.test
//
//  Created by Jordan Kiley on 9/3/16.
//  Copyright © 2016 Jordan Kiley. All rights reserved.
//

import Foundation
import UIKit

class BatteryStatus {
    
    static var device = UIDevice.current
    var chargingStatus : Bool = true
    
    func isPhoneCharging() -> Bool {
        
        switch BatteryStatus.device.batteryState {
        case .charging:
            print("charging")
            print(BatteryStatus.device.batteryLevel)
            chargingStatus = true
            
        case .full:
            print("all done")
            chargingStatus = false
            
        default:
            print("nope")
            chargingStatus = false
        }
        return chargingStatus
    }
    

}
