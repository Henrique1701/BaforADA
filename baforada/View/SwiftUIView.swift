//
//  SwiftUIView.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 10/02/21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Bem-vindo ao")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Text("Baforada")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1.0, green: 0.902, blue: -0.004))
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 60.0, height: 60.0)
                            .foregroundColor(Color(red: 1.0, green: 0.902, blue: -0.004))
                            
                            
                        VStack(alignment: .leading) {
                            Text("Habilite a Localização")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .frame(width: /*@START_MENU_TOKEN@*/170.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/29.0/*@END_MENU_TOKEN@*/)
                            
                            Text("Descubra onde estão os bêbados mais próximos de você")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                                .frame(width: 187.0, height: 39.0)
                                
                        }
                        
                    }
                    .padding(.all)
                    
                    HStack {
                        Image("icon-drunk")
                            .resizable()
                            .frame(width: 68.0, height: 68.0)
                            .foregroundColor(Color.yellow)
                            
                            
                        VStack(alignment: .leading) {
                            Text("Faça o nosso teste")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                
                            
                            Text("Com o nosso bafômetro virtual, tenha certeza do seu estado de embriaguez!")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                                .frame(width: 178.0, height: 57.0)
                                
                        }
                        
                    }
                    .padding(.all)
                    
                    HStack {
                        Image(systemName: "map.fill")
                            .resizable()
                            .frame(width: 60.0, height: 60.0)
                            .foregroundColor(Color(red: 1.0, green: 0.902, blue: -0.004))
                            
                            
                        VStack(alignment: .leading) {
                            Text("Descubra sua cidade")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                
                            
                            Text("O mapa apresentará onde tem mais bêbado falhando o teste")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
                                .frame(width: 178.0, height: 44.0)
                                
                        }
                        
                    }
                    .padding(.all)
                }
                
                Spacer()
                NavigationLink(
                    destination: ContentView(),
                    label: {
                        Text("Navigate")
                            .foregroundColor(Color.white)
                    })
                Button(action: {
                    
                }, label: {
                    Text("Avançar")
                        .padding()
                        .foregroundColor(Color.black)
                        .frame(width: 260.0, height: 50.0)
                        .background(Color(red: 1.0, green: 0.902, blue: -0.004))
                        .cornerRadius(30)
                })
            }
            
            
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
