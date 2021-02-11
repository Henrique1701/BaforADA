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
        //getDrunks()
        
    }
    
    func changeLocation(){
        var locatione = getLocation()
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (locatione?.coordinate.latitude)!, longitude: (locatione?.coordinate.longitude)!), latitudinalMeters: 10000, longitudinalMeters: 10000)
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
    
    func updateDrunk(id: String, drunkness: Int) {
        publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: id)){ record, error in
            DispatchQueue.main.async {
                if error == nil {
                    let location: CLLocation? = self.getLocation()
                    record!.setValue(drunkness, forKey: "drunkness")
                    record!.setValue(Date(), forKey: "lastTest")
                    record!.setValue(location, forKey: "location")
                    self.publicDatabase.save(record!) {(savedRecord, error) in
                        DispatchQueue.main.async {
                            if error == nil {
                                print("Deu certo, atualizou")
                                self.managerDelegate.pins = []
                                self.drunks = []
                                self.getDrunks()
                            } else {
                                print("Deu errado")
                                print(error)
                            }
                        }
                    }
                } else {
                    print("Deu erro na busca")
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
