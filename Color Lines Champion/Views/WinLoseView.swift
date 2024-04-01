//
//  WinLoseView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 1.04.24.
//

import SwiftUI

struct WinLoseView: View {
    @State var typeOfView: WinLose
    @Binding var score: Int
    @Binding var bestScore: Int
    @Binding var presentView:Bool
    var body: some View {
        
        ZStack{
            Color.black.opacity(0.5)
            VStack {
                Image(typeOfView.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal,64)
                    .padding(.bottom,16)
                ZStack{
                    Image("bgScore")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack{
                        Text("Score: \(score)")
                            .font(.custom("MultiroundPro", size: 20))
                            .foregroundColor(Color("Yellow"))
                            .padding(.bottom,16)
                        Text("Best Score: \(bestScore)")
                            .font(.custom("MultiroundPro", size: 20))
                            .foregroundColor(Color("Yellow"))
                    }
                }
                .padding(.horizontal,64)
                .padding(.bottom,16)
                
                HStack{
                    
                    NavigationLink(destination: GameSwiftUIView().navigationBarHidden(true)){
                        Image("startAgain")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.onTapGesture {
                        presentView.toggle()
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: MenuView().navigationBarHidden(true)){
                        Image("backMenu")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                          
                    }.onTapGesture {
                        presentView.toggle()
                    }
                    
                }.padding(.horizontal,16)
                
            }
        }
    }
}


enum WinLose: String {
    case win
    case lose
}


