//
//  ContentView.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 03/02/21.
//

import SwiftUI

struct TestIntroView: View {
    
    var sensorDevice: SensorDevice
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Baforada")
                        .foregroundColor(.beerYellow)
                        .font(.system(size: 50, weight: .bold, design: .default))
                    Spacer()
                }
                .padding(20)
                Spacer()
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Faça o nosso teste")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold, design: .default))
                        Text("E descubra o seu grau de embriaguez")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .frame(maxWidth: 200)
                        
                        
                    }
                    
                    Spacer()
                }
                .padding(20)
                .padding(.bottom, 40)
                
                Image("drunkperson")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(100)
                Spacer()
                NavigationLink(destination: ActivityDescriptionView(sensorDevice: sensorDevice, name: "Fazer o quatro", description: "Você provavelmente já fez muitos desses para provar que não estava tão bêbado assim... Tente se equilibrar por 10 segundos fazendo o número quarto com as pernas com o celular parado! Nós vamos saber se você não fizer ou se mexer o celular!", index: "Primeira atividade")){
                    Text("começar")
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .padding(.horizontal, 80)
                        .background(Color.beerYellow)
                        .cornerRadius(14)
                }
                .padding(.bottom, 30)
            }
            .background(Color.darkGray)
            .navigationBarHidden(true)
        }
    }
}

//struct TestIntroView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(bank: DrunkBank())
//    }
//}


