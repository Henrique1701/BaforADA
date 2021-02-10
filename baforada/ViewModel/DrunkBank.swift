//
//  DrunkBank.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 04/02/21.
//

import Foundation
import SwiftUI
import MapKit
import CloudKit
import CoreLocation
import Combine

class DrunkBank: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    @Published var drunks: [Drunk] = []
    @Published var alertSaveSuccess: Bool = false
    @Published var alertSaveError: Bool = false
    
    let publicDatabase = CKContainer(identifier: "iCloud.academy.ufpe.br.baforada").publicCloudDatabase
    
    override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if !(UserDefaults.standard.bool(forKey: "userCreated")) {
            setDrunk(drunkness: 0)
        }
        getDrunks()
    }
    
    func getDrunks() {
        var drunkRecords: [CKRecord] = []
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Drunk", predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async{
                drunkRecords.append(record)
            }
        }
        
        operation.queryCompletionBlock = { cursor, error in
            DispatchQueue.main.async {
                for record in drunkRecords {
                    let drunk = Drunk(recordName: record.recordID.recordName, lastTest: record["lastTest"] as! Date, location: record["location"] as! CLLocation, drunkness: record["drunkness"] as! Int)
                    self.drunks.append(drunk)
                }
            }
        }
        
        publicDatabase.add(operation)
    }
    
    func setDrunk(drunkness: Int) {
        UserDefaults.standard.set(true, forKey: "userCreated")
        
        let drunk = CKRecord(recordType: "Drunk")
        drunk.setValue(drunkness, forKey: "drunkness")
        drunk.setValue(Date(), forKey: "lastTest")
        let location: CLLocation? = getLocation()
        drunk.setValue(location, forKey: "location")
        let recordName = drunk.recordID.recordName
        UserDefaults.standard.setValue(recordName, forKey: "recordName")
        
        self.publicDatabase.save(drunk) { (savedRecord, error) in
            DispatchQueue.main.async {
                if error == nil {
                    print("Deu certo")
                } else {
                    print("Deu errado")
                    print(error)
                }
            }
        }
    }
    
    func getLocation() -> CLLocation? {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        } else {
            print("Não autorizou a localização")
        }
        
        if self.locationManager.location != nil {
            return self.locationManager.location
        } else {
            // TODO: Ele entra aqui quando o ussuário abri o app pela primeira vez, ou não autoria a localização
            return CLLocation(latitude: -8.0578, longitude: -34.8829)
        }
        
    }
}
