//
//  ContentView.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 03/02/21.
//

import SwiftUI

struct ActivityDescriptionView: View {
    
    @ObservedObject var sensorDevice: SensorDevice
    
    var name: String
    
    var description: String
    
    var index: String
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text(index)
                        .foregroundColor(.beerYellow)
                        .font(.system(size: 50, weight: .bold, design: .default))
                    Spacer()
                }
                .padding(20)
                Spacer()
                
                HStack{
                    VStack(alignment: .leading){
                        Text(name)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold, design: .default))
                        Text(description)
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .regular, design: .default))
                        
                        
                        
                    }
                    
                    Spacer()
                }
                .padding(20)
                
                Text(sensorDevice.debugText)
                
                Spacer()
                Button(action:{
                    sensorDevice.startObserve()
                }){
                    Text("Tô preparado")
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .padding(.horizontal, 80)
                        .background(Color.beerYellow)
                        .cornerRadius(14)
                }
                .padding(.bottom, 30)
                .opacity(sensorDevice.hasStarted ? 0 : 1)
            }
            .background(Color.darkGray)
            .navigationBarHidden(true)
            
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.green)
                .position(x: sensorDevice.centerX, y: sensorDevice.centerY)
            
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.beerYellow)
                .position(x: sensorDevice.drunkX, y: sensorDevice.drunkY)
            
            NavigationLink(
                destination: ShowResultView(drunkness: sensorDevice.drunkness, isActive: $sensorDevice.endedTest),
                isActive: $sensorDevice.endedTest){
                EmptyView()
            }
            
        }
        
    }
}

struct ActivityDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDescriptionView(sensorDevice: SensorDevice(bank: DrunkBank()), name: "Fazer o quatro", description: "Você provavelmente já fez muitos desses para provar que não estava tão bêbado assim... Tente se equilibrar por 10 segundos fazendo o número quarto com as pernas com o celular parado! Nós vamos saber se você não fizer ou se mexer o celular!", index: "Primeira atividade")
    }
}


