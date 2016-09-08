//
//  ViewController.swift
//  flic.test
//
//  Created by Jordan Kiley on 9/3/16.
//  Copyright © 2016 Jordan Kiley. All rights reserved.
//


// detect if device is plugged into switch
// detect if phone is charged
// turn off if charged
// Monitor if app is in the background
//detect level of charge, change switch color
// Have user toggle switch to detect if device is plugged in
// what if the user has multiple switches

import UIKit
import HomeKit
import ExternalAccessory

class ViewController: UIViewController, HMAccessoryBrowserDelegate, HMHomeManagerDelegate {
    //var home = HMHome()
    var homeManager = HMHomeManager()
    let accessoryBrowser = HMAccessoryBrowser()
    var accessories = [HMAccessory]()
    @IBOutlet weak var devicePluggedIn: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        BatteryStatus.device.isBatteryMonitoringEnabled = true
        homeManager.delegate = self
        homeManager.addHome(withName: "Main home") { (home, error) in
            
        }
        accessoryBrowser.delegate = self
        
        
        //homeManager.primaryHome?.addAccessory(<#T##accessory: HMAccessory##HMAccessory#>, completionHandler: <#T##(Error?) -> Void#>)
        print(homeManager.homes)
        findHomeKitSwitch()
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var timer = Timer.scheduledTimer(timeInterval: 10.0, target:self, selector: Selector(("checkIfCharging")), userInfo: nil, repeats: true)
        if BatteryStatus().chargingStatus {
            checkIfCharging()
        }
    }
    
    func checkIfCharging() {
        BatteryStatus().isPhoneCharging()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDevices() {
        accessoryBrowser.delegate = self
        accessoryBrowser.startSearchingForNewAccessories()
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        print(accessory)
        for service in accessory.services {
            if service.serviceType.contains(HMServiceTypeOutlet) {
                homeManager.primaryHome?.addAccessory(accessory, completionHandler: { (error) in
                    if error != nil {
                        return
                    }
                })
                print(accessory.services)
                break
            }
        }
    }
    
    func findHomeKitSwitch() {
        
    }
}

