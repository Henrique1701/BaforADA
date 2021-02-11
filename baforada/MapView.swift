//
//  MapView.swift
//  baforada
//
//  Created by Victor Vieira on 10/02/21.
//

import SwiftUI
import MapKit


struct Mapi: View{
    var cores:[Color] = [.red, .orange, .green]
    var index = 1
//    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -8.0578, longitude: -34.8829), latitudinalMeters: 10000, longitudinalMeters: 10000)
//    @State var trancking: MapUserTrackingMode = .follow
//    @State var manager = CLLocationManager()
//    @StateObject var managerDelegate = locationDelegate()
    @ObservedObject var bank: DrunkBank
    
    
    var body: some View{
        VStack{
            Map(coordinateRegion: $bank.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $bank.tracking, annotationItems:bank.managerDelegate.pins) { pin in
                MapAnnotation(coordinate: pin.location.coordinate) {
                    Image(pin.drunkness)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .offset(y: -25)
                }
                
                //MapPin(coordinate: pin.location.coordinate, tint: pin.color)
                
            }
            
        }
        .onAppear {
           
        }
    }
}

class locationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var pins: [Pin] = []{
        didSet{
            self.objectWillChange.send()
        }
    }
    var drunkness:[String] = ["notDrunk", "halfDrunk", "fullDrunk"]
    var index = 1
    
    
    func addPins(_ drunks: [Drunk]){
        pins = []
        for drunk in drunks{
            pins.append(Pin(location: drunk.location, drunkness: drunkness[drunk.drunkness]))
        }
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

struct Pin: Identifiable{
    var id = UUID().uuidString
    var location: CLLocation
    var drunkness: String
}
