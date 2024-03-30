//
//  MenuView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 30.03.24.
//

import SwiftUI
import SafariServices

struct MenuView: View {
    @State var isPresentedSafari: Bool = false
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
                        .padding(.horizontal,32)
                    
                    NavigationLink(destination: LoadingView()){
                        
                        Text("PLAY NOW")
                            .font(.custom("MultiroundPro", size: 30))
                            .foregroundColor(Color("Black"))
                            .padding(.vertical,16)
                            .padding(.horizontal,32)
                            .background(
                                Image("PlayNowButton")
                                    .resizable()
                            )
                    }.padding(.bottom,16)
                    
                    Button(action: {
                        isPresentedSafari = true
                    }){
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
            }.fullScreenCover(isPresented: $isPresentedSafari){
                
                PrivacyPolicyView(url: URL(string: "https://t0.gstatic.com/licensed-image?q=tbn:ANd9GcTZCSmCzmIPm0up8wmW566cK5w3sSTUChT5UnaU3VnFxrHwoRNSnks0xUBmj2r2oeJk")!, isPresentedSafari: $isPresentedSafari).ignoresSafeArea()
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    MenuView()
}

struct PrivacyPolicyView: UIViewControllerRepresentable {
    let url: URL
    @Binding var isPresentedSafari: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let safariViewController = SFSafariViewController(url: url)
 
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(Coordinator.closeSafari))
        safariViewController.navigationItem.rightBarButtonItem = closeButton
        
        return safariViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: PrivacyPolicyView
        
        init(parent: PrivacyPolicyView) {
            self.parent = parent
        }
        
        @objc func closeSafari() {
            parent.isPresentedSafari = false
        }
    }
}
