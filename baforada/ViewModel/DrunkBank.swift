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

class DrunkBank: ObservableObject {
    
    @Published var drunks: [Drunk] = []
    
    let publicDatabase = CKContainer(identifier: "Drunk").publicCloudDatabase
    
    init() {
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
            }
        }
        
        publicDatabase.add(operation)
    }
}
