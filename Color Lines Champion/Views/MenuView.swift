//
//  MenuView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 30.03.24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image(ImageResource(name: "Background", bundle: Bundle.main ))
                    .resizable()
                
                VStack{
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom,64)
                        .padding(.horizontal,16)
                    
                    NavigationLink(destination: LoadingView()){
                        
                        Text("PLAY NOW")
                            .font(.custom("MultiroundPro", size: 30))
                            .foregroundColor(Color("Black"))
                            .padding(.vertical,16)
                            .padding(.horizontal,32)
                            .background(Image("PlayNowButton")
                                .resizable())
                    }.padding(.bottom,16)
                    
                    NavigationLink(destination: LoadingView()){
                        
                        Text("PRIVACY POLICY")
                            .font(.custom("MultiroundPro", size: 15))
                            .foregroundColor(Color("Black"))
                            .padding(.all,12)
                            .background(
                            Image("PlayNowButton")
                                .resizable()
                            )
                        
                    }
                    
                }
                
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    MenuView()
}


struct PlayNow: View {
    var body: some View {
        VStack{
            Text("PLAY NOW")
                .multilineTextAlignment(.center)
        }
        
        
    }
}
