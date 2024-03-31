//
//  GameView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 30.03.24.
//

import Foundation
import SwiftUI
import SpriteKit

struct GameView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        // Создаем сцену SpriteKit
        var scene: SKScene {
            let scene = GameScene()
            scene.size = CGSize(width: 300, height: 500)
//            scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            scene.scaleMode = .aspectFit
           
            return scene
        }
        
        // Создаем view для отображения сцены
        let skView = SKView()
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        // Этот метод не требуется для этого примера
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
