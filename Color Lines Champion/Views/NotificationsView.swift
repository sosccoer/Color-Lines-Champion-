//
//  ContentView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 29.03.24.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image(ImageResource(name: "Background", bundle: Bundle.main ))
                    .resizable()
                
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.9)
                
                VStack{
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top,100)
                    
                    Spacer()
                    
                    Text("ALLOW NOTIFICATIONS ABOUT \n BONUSES AND PROMS")
                        .font(.custom("Inter-Bold", size: 23))
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                        .foregroundColor(Color("White"))
                        .padding(.bottom,16)
                        .padding(.horizontal,16)
                    
                    Text("Stay tuned with best offers from \n our casino")
                        .font(.custom("Inter-Medium", size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Gray"))
                        .padding(.bottom,16)
                    
                    NavigationLink(destination: MenuView()){
                        Text("Yes, I Want Bonuses!")
                            .font(.custom("Inter-Medium", size: 20))
                            .foregroundStyle(Color("Black"))
                            .padding(.vertical,16)
                            .padding(.horizontal,48)
                            .background(Color("Yellow"))
                            .cornerRadius(22.68)
                            .padding(.horizontal,16)
                            .padding(.bottom,16)
                    }
                    
                    NavigationLink(destination: MenuView()){
                        Text("Skip").font(.custom("Inter-Medium", size: 20)).foregroundStyle(Color("Gray"))
                    }.padding(.bottom,32)
                    
                }
                
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    NotificationsView()
}
