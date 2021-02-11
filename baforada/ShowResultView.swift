//
//  ShowResultView.swift
//  baforada
//
//  Created by Samuel Brasileiro on 10/02/21.
//

import SwiftUI

struct ShowResultView: View {
    
    var drunkness: Drunkness
    
    @Binding var isActive: Bool
    
    var body: some View {
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
            
            Text(String(drunkness.rawValue))
            
            Image("drunkperson")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(100)
            Spacer()
            
        }
        .background(Color.darkGray)
        .navigationBarHidden(true)
    }
}


