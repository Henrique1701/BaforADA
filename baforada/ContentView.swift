//
//  ContentView.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 03/02/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bank = DrunkBank()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
