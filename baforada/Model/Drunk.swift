//
//  Drunk.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 04/02/21.
//

import Foundation
import SwiftUI
import MapKit

class Drunk {
    
    var recordName: String
    var lastTest: Date
    var location: CLLocationCoordinate2D
    
    init (recordName: String, lastTest: Date, location: CLLocationCoordinate2D) {
        self.recordName = recordName
        self.lastTest = lastTest
        self.location = location
    }
}
