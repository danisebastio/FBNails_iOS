//
//  SplashScreenView.swift
//  FBNails
//
//  Created by Daniele Sebastio on 25/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.primaryPink
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                
                Text("FB")
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("nails")
                    .font(.system(size: 20))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
