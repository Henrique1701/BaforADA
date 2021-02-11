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
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -8.0578, longitude: -34.8829), latitudinalMeters: 10000, longitudinalMeters: 10000)
    @Published var tracking: MapUserTrackingMode = .follow
    @Published var manager = CLLocationManager()
    @Published var managerDelegate = locationDelegate()
    
    
    let publicDatabase = CKContainer(identifier: "iCloud.academy.ufpe.br.baforada").publicCloudDatabase
    
    override init() {
        super.init()
        manager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
        
        
        manager.delegate = managerDelegate
        getDrunks()
        
    }
    
    func getDrunks(){
        print("Iniciou getDrunks")
        var drunkRecords: [CKRecord] = []
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Drunk", predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async{
                print("achou alguem")
                drunkRecords.append(record)
                
            }
        }
        
        operation.queryCompletionBlock = { cursor, error in
            DispatchQueue.main.async {
                print("terminou de achar")
                for record in drunkRecords {
                    let drunk = Drunk(recordName: record.recordID.recordName, lastTest: record["lastTest"] as! Date, location: record["location"] as! CLLocation, drunkness: record["drunkness"] as! Int)
                    self.drunks.append(drunk)
                    print(drunk.location)
                }
                self.managerDelegate.addPins(self.drunks)
                self.objectWillChange.send()
            }
        }
        
        publicDatabase.add(operation)
        
    }
    
    func setDrunk(drunkness: Int) {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            return
        }
        UserDefaults.standard.set(true, forKey: "userCreated")
        let drunk = CKRecord(recordType: "Drunk")
        drunk.setValue(drunkness, forKey: "drunkness")
        drunk.setValue(Date(), forKey: "lastTest")
        while CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            print("aqui")
        }
        let location: CLLocation? = getLocation()
        drunk.setValue(location, forKey: "location")
        let recordName = drunk.recordID.recordName
        UserDefaults.standard.setValue(recordName, forKey: "recordName")
        
        self.publicDatabase.save(drunk) { (savedRecord, error) in
            DispatchQueue.main.async {
                if error == nil {
                    print("Deu certo")
                    self.getDrunks()
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
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
//            print("Authorized")
//            manager.startUpdatingLocation()
//            if !(UserDefaults.standard.bool(forKey: "userCreated")) {
//                setDrunk(drunkness: 1)
//            }
//        }
//        else{
//            print("Not Authorized")
//
//            manager.requestWhenInUseAuthorization()
//        }
//
//    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("entrou")
    }
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
//            print("Authorized")
//            manager.startUpdatingLocation()
//        }
//        else{
//            print("Not Authorized")
//            
//            manager.requestWhenInUseAuthorization()
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New Location")
//        pins.append(Pin(location: locations.last!, drunkness: drunkness[index]))
//        if index<2 {
//            index += 1
//        }
//        else{
//            index = 0
//        }
    }
    
}
