//
//  SensorDevice.swift
//  baforada
//
//  Created by Samuel Brasileiro on 08/02/21.
//

import Foundation

import SwiftUI
import CoreMotion
import MapKit
import CloudKit

enum Drunkness: Int{
    case low
    case mid
    case high
}

class SensorDevice: ObservableObject {
    
    
    @Published  var debugText: String = "debug"
    
    @Published var hasStarted: Bool = false
    
    let motionManager = CMMotionManager()
    
    var device = UIDevice.current
    var timer = Timer()
    var timeCounter = 0
    var sensorTimer = Timer()
    
    @Published var centerX = UIScreen.main.bounds.midX
    @Published var centerY = UIScreen.main.bounds.midY
    
    @Published var drunkX = UIScreen.main.bounds.midX
    @Published var drunkY = UIScreen.main.bounds.midY
    @Published var bank: DrunkBank
    
    @Published var endedTest = false
    
    @Published var drunkness: Drunkness = .low
    
    init(bank: DrunkBank) {
        self.bank = bank
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 10
        self.motionManager.accelerometerUpdateInterval = 1.0 / 10
        self.motionManager.gyroUpdateInterval = 1.0 / 10
        
        self.motionManager.startAccelerometerUpdates()
        self.motionManager.startGyroUpdates()
        self.motionManager.showsDeviceMovementDisplay = true
        self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
        
    }
    
    
    func startObserve () {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0 / 10 , target: self, selector: (#selector(self.updateCounterLabel)), userInfo: nil, repeats: true)
        totalDiffRoll = 0
        totalDiffPitch = 0
        oldRoll = nil
        oldPitch = nil
        hasStarted = true
    }
    
    var totalDiffPitch: Double = 0.0
    var totalDiffRoll: Double = 0.0
    
    var oldPitch: Double?
    var oldRoll: Double?
    
    @objc func updateCounterLabel () {
        
        if let data = self.motionManager.deviceMotion{
            print("pitch ", data.attitude.pitch)
            print("roll ", data.attitude.roll)
            print("totalp \(totalDiffPitch)")
            print("totalr \(totalDiffRoll)\n")
            
            if let oldPitch = self.oldPitch, let oldRoll = self.oldRoll{
                
                totalDiffPitch += Double.squareRoot(abs(pow(data.attitude.pitch, 2) - pow(oldPitch, 2)))()
                
                totalDiffRoll += Double.squareRoot(abs(pow(data.attitude.roll, 2) - pow(oldRoll, 2)))()
                
                //drunkX += CGFloat(data.attitude.roll * 10)
                drunkY += CGFloat(data.attitude.pitch - 1)
                
            }
            self.oldPitch = data.attitude.pitch
            self.oldRoll = data.attitude.roll
            
            debugText = ""
            debugText += ("pitch  \(data.attitude.pitch)\n")
            debugText += ("roll   \(data.attitude.roll)\n")
            debugText += ("totalp \(totalDiffPitch)\n")
            debugText += ("totalr \(totalDiffRoll)\n")

            
        }
        
        if let data = self.motionManager.accelerometerData{
            
            debugText += ("ace x  \(data.acceleration.x)\n")
            debugText += ("ace y  \(data.acceleration.y)\n")
            debugText += ("ace z  \(data.acceleration.z)\n")
            
            drunkX += CGFloat(data.acceleration.x * 10)
            //drunkY -= CGFloat((data.acceleration.z) * 10)

            
        }

        
        if timeCounter >= 100{//10 seg
            timeCounter = 0
            timer.invalidate()
            self.hasStarted = false
            debugText = ""
            
            debugText = ("totalp \(totalDiffPitch)\ntotalr \(totalDiffRoll)\n")
            
            if totalDiffPitch > 17 || totalDiffRoll > 8 {
                drunkness = .high
            }
            else if totalDiffPitch > 11 || totalDiffRoll > 5 {
                drunkness = .mid
            }
            else{
                drunkness = .low
            }
              
            if !(UserDefaults.standard.bool(forKey: "userCreated")) {
                self.bank.setDrunk(drunkness: drunkness.rawValue)
                print("setando")
            }
            
            endedTest = true
        }
        timeCounter += 1
        
        
    }
    
}
