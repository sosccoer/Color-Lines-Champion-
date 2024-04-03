//
//  SettingsView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 1.04.24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isPresented: Bool
    @Binding var vibrationToggle: Bool
    @Binding var soundToggle: Bool
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.5)
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
            ZStack{
                Image("SettingsText")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack{
                    Image("sound")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing,8)
                    Image("vibro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading,8)
                }.padding(.horizontal,32)
                    .padding(.top,80)
                
                HStack {
                    Toggle("", isOn: $soundToggle)
                        .toggleStyle(ImageToggleStyle(onImageName: "On", offImageName: "Off"))
                        .padding(.trailing,8)
                    
                    Toggle("", isOn: $vibrationToggle)
                        .toggleStyle(ImageToggleStyle(onImageName: "On", offImageName: "Off"))
                        .padding(.leading,8)
                }.padding(.horizontal,32)
                    .padding(.top,170)
                
            }
            .padding(.horizontal,85)
            .padding(.top,60)
            
            Button(action: {
                isPresented.toggle()
            }){
                Image("backSettings")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding(.top,440)
            .padding(.horizontal,120)
            
        }.background(Color.clear)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true), vibrationToggle: .constant(false), soundToggle: .constant(true))
            .previewLayout(.fixed(width: 400, height: 800)) // Регулируйте размеры по вашему усмотрению
    }
}

import SwiftUI
struct ImageToggleStyle: ToggleStyle {
    var onImageName: String; var offImageName: String
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(configuration.isOn ? onImageName : offImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
                . frame(width: 65, height: 35, alignment: .center)
                .overlay(
                    Circle()
                        . foregroundColor(.white)
                        . padding(.all, 9)
                        .offset(x: configuration.isOn ? 20 : -20, y: 0)
                        . animation(Animation.linear (duration: 0.1))
                ).cornerRadius (20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
