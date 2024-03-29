//
//  LoadingView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 30.03.24.
//

import SwiftUI

struct LoadingView: View {
    @State private var offsets: [CGFloat] = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    @State private var isPresentedNextView = false
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
            
            VStack {
                HStack(spacing: 0) {
                    ForEach(0..<offsets.count, id: \.self) { index in
                        Text(String("Loading..."[String.Index(utf16Offset: index, in: "Loading...")]))
                            .font(.custom("BungeeSpice-Regular", size: 30))
                            .offset(y: self.offsets[index])
                    }
                }
            }
            .padding()
            .onAppear {
                let delays = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
                for i in 0..<self.offsets.count {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(delays[i])) {
                        self.offsets[i] = -10
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    isPresentedNextView = true
                    
                }
              
            }
            .fullScreenCover(isPresented: $isPresentedNextView, content: {
                NotificationsView()
            })
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
    }
    
    
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

