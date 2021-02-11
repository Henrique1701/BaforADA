//
//  ContentView.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 03/02/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bank: DrunkBank
    
    var body: some View {
        
        TabView{
            TestIntroView(sensorDevice: SensorDevice(bank: bank))
                .tabItem {
                    Image(systemName: "wind")
                    Text("Baforar")
                        .tag("0")
                }
                .navigationBarHidden(true)
            
            Mapi(bank: bank)
                .tabItem {
                    Image(systemName: "map")
                    Text("Mapa")
                        .tag("1")
                }
                .navigationBarHidden(true)
            
        }
        .accentColor(.beerYellow)
        .background(Color.darkGray)
        .environment(\.colorScheme, .dark)
        .ignoresSafeArea()
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
