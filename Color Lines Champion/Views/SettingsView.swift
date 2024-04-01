//
//  SettingsView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 1.04.24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack{
            Color.clear
            Image("SettingsTriangle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal,96)
                .padding(.bottom,120)
            
            
            Image("BackGroundSettings")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal,75)
                .padding(.top,200)
            
            Image("SettingsText")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal,85)
                .padding(.top,60)
            
            Button(action: {
                isPresented.toggle()
            }){
                Image("backSettings")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.top,400)
            .padding(.horizontal,120)
            
            
        }.background(.clear)
    }
}

//#Preview {
//    SettingsView()
//}
