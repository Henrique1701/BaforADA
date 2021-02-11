//
//  drunknessStateView.swift
//  baforada
//
//  Created by José Henrique Fernandes Silva on 11/02/21.
//

import SwiftUI

struct DrunknessStateView: View {
    
    @State var drunkness: Int = 0
    
    var body: some View {
        
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            
            if drunkness == 0 {
                let title = "Oxe, tá de boa!"
                let description = "Tais começando a ficar no brilho ainda, pode tomar cachaça a vontade ;)"
                let imageName = "drunkness-state-one"
                drunknessInformation(title: title, description: description, imageName: imageName)
            } else if drunkness == 1 {
                let title = "Vai com calma!"
                let description = "Tais ficando bêbado, visse. Mas, ainda aguenta uma saideira ;)"
                let imageName = "drunkness-state-two"
                drunknessInformation(title: title, description: description, imageName: imageName)
            } else {
                let title = "Vixe, tais bêbado!"
                let description = "Meu véi, tais bêbado que nem a gota. Vai timbora para casa :("
                let imageName = "drunkness-state-three"
                drunknessInformation(title: title, description: description, imageName: imageName)
            }
        }
         
    }
}

func drunknessInformation(title: String, description: String, imageName: String) -> some View {
    
    VStack {
        Spacer()
        
        Text(title)
            .font(.largeTitle)
            .foregroundColor(.white)
        
        Text(description)
            .font(.callout)
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
        
        Spacer()
        
        Image(imageName)
        
        Spacer()
    }
    .padding()
    .navigationBarHidden(true)
    
    
}

struct drunknessStateView_Previews: PreviewProvider {
    static var previews: some View {
        DrunknessStateView(drunkness: 2)
    }
}
