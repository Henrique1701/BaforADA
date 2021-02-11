//
//  Onboarding.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 11/02/21.
//

import SwiftUI

struct Onboarding: View {
    
    @ObservedObject var bank: DrunkBank
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(.black).edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Bem-vindo ao")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .padding(.top)
                            
                            Text("Baforada")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 1.0, green: 0.902, blue: -0.004))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                            
                        }
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .foregroundColor(Color(red: 1.0, green: 0.902, blue: -0.004))
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Habilite a Localização")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: geometry.size.width * 0.41)
                                    
                                    Text("Descubra onde estão os bêbados mais próximos de você")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                                        .frame(width: geometry.size.width * 0.45)
                                    
                                }
                                
                            }
                            .padding(.all)
                            
                            HStack {
                                Image("icon-drunk")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.18, height: geometry.size.width * 0.18)
                                    .foregroundColor(Color.yellow)
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Faça o nosso teste")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, geometry.size.width * 0.01)
                                    
                                    
                                    Text("Com o nosso bafômetro virtual, tenha certeza do seu estado de embriaguez!")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                                        .frame(width: geometry.size.width * 0.45)
                                    
                                }
                                
                            }
                            .padding(.all)
                            
                            HStack {
                                Image(systemName: "map.fill")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .foregroundColor(Color(red: 1.0, green: 0.902, blue: -0.004))
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Descubra sua cidade")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading, geometry.size.width * 0.02)
                                    
                                    
                                    Text("O mapa apresentará onde tem mais bêbado falhando o teste")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                                        .frame(width: geometry.size.width * 0.45)
                                    
                                }
                                
                            }
                            .padding(.all)
                        }
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: ContentView(bank: bank)) {
                            Text("Avançar")
                                .foregroundColor(Color.black)
                                .frame(width: geometry.size.width / 2, height: geometry.size.height / 15 )
                                .background(Color(red: 1.0, green: 0.902, blue: -0.004))
                                .cornerRadius(15)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(bank: DrunkBank())
    }
}
