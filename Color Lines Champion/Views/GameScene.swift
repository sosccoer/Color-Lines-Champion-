//
//  GameScene.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 30.03.24.
//

import Foundation
import SpriteKit
import UIKit

class GameScene: SKScene {
    var gridSize = 9
    var cellSize = CGSize(width: 40, height: 40)
    var selectedBall: SKShapeNode?

    override func didMove(to view: SKView) {
        
        // Размеры сетки
        
        //        = CGSize(width: sceneWidth / CGFloat(gridSize), height: sceneWidth / CGFloat(gridSize))
        //        var grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        //
        //        let gridHand: [[(Int, Int)]] = [
        //            [(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0), (6, 0), (7, 0), (8, 0)],
        //            [(0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1)],
        //            [(0, 2), (1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2)],
        //            [(0, 3), (1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3), (7, 3), (8, 3)],
        //            [(0, 4), (1, 4), (2, 4), (3, 4), (4, 4), (5, 4), (6, 4), (7, 4), (8, 4)],
        //            [(0, 5), (1, 5), (2, 5), (3, 5), (4, 5), (5, 5), (6, 5), (7, 5), (8, 5)],
        //            [(0, 6), (1, 6), (2, 6), (3, 6), (4, 6), (5, 6), (6, 6), (7, 6), (8, 6)],
        //            [(0, 7), (1, 7), (2, 7), (3, 7), (4, 7), (5, 7), (6, 7), (7, 7), (8, 7)],
        //            [(0, 8), (1, 8), (2, 8), (3, 8), (4, 8), (5, 8), (6, 8), (7, 8), (8, 8)]
        //        ]
        //
        createPlayZone()
        createRandomBalls(size: .big)
        createRandomBalls(size: .small)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let touchLocation = touch.location(in: self)
            
            // Проверяем, попали ли в какой-то из маленьких шариков
            let nodes = self.nodes(at: touchLocation)
            for node in nodes {
                if node.name == "ball" {
                    // Если попали, сохраняем ссылку на шарик
                    selectedBall = node as? SKShapeNode
                    return
                }
            }
        }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedBall = selectedBall, let touch = touches.first else { return }
        
        // Получаем местоположение касания
        let touchLocation = touch.location(in: self)
        
        // Определяем ближайшую ячейку сетки
        let gridX = Int(round(touchLocation.x / cellSize.width))
        let gridY = Int(round(touchLocation.y / cellSize.height))
        let newX = CGFloat(gridX) * cellSize.width + cellSize.width / 2
        let newY = CGFloat(gridY) * cellSize.height + cellSize.height / 2
        
        // Перемещаем шарик в ближайшую ячейку сетки
        selectedBall.position = CGPoint(x: newX, y: newY)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectedBall = selectedBall else { return }
        
        // Определяем ближайшую точку сетки
        let gridX = Int(round(selectedBall.position.x / cellSize.width))
        let gridY = Int(round(selectedBall.position.y / cellSize.height))
        let newX = CGFloat(gridX) * cellSize.width + cellSize.width / 2
        let newY = CGFloat(gridY) * cellSize.height + cellSize.height / 2
        
        // Перемещаем шарик в ближайшую точку сетки
        selectedBall.position = CGPoint(x: newX, y: newY)
    }


    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//        
//        let touchLocation = touch.location(in: self)
//        let touchedNode = atPoint(touchLocation)
//        
//        // Если коснулись пустой ячейки, добавляем шарик
//        if touchedNode.name?.hasPrefix("cell") == true {
//            addOrRemoveBall(at: touchedNode.position)
//            print(touchedNode.name)
//        }
//    }
    
    func addOrRemoveBall(at position: CGPoint) {
        let col = Int(position.x / cellSize.width)
        let row = Int(position.y / cellSize.height)
        let nodeName = "cell\(col)_\(row)"
        
        if let cell = childNode(withName: nodeName) as? SKSpriteNode {
            // Проверяем, есть ли шарик в ячейке
            if cell.children.isEmpty {
                // Добавляем шарик
                let ball = SKShapeNode(circleOfRadius: min(cellSize.width, cellSize.height) / 2 - 5)
                ball.fillColor = randomColor()
                ball.position = cell.position
                ball.name = "ball"
                addChild(ball)
            } else {
                // Удаляем шарик
                cell.children.forEach { $0.removeFromParent() }
            }
        }
    }
    
    func createPlayZone() {
        
        for row in 0..<gridSize {
            for col in 0..<gridSize {
                let cell = SKSpriteNode(color: .white, size: cellSize)
                cell.position = CGPoint(x: CGFloat(col) * cellSize.width + cellSize.width / 2,
                                        y: CGFloat(row) * cellSize.height + cellSize.height / 2)
                cell.name = "cell\(col)_\(row)"
                
                
                // Добавляем границы для ячейки
                let border = SKShapeNode(rectOf: cellSize)
                border.position = cell.position
                border.strokeColor = .black
                border.lineWidth = 2.0
                addChild(border)
                addChild(cell)
            }
        }
        
    }
    
    func randomColor() -> UIColor {
        let colors: [UIColor] = [.red, .blue, .green, .yellow]
        return colors.randomElement() ?? .white
    }
    
    func createRandomBalls(size:SizeOfBall) {
        var ballsAdded = 0
        var ballsNeded: Int{
            
            switch size{
            case .small:
                return 3
            case .big:
                return  5
                
            }
        }
        var ballInit: SKShapeNode {
            switch size{
            case .small:
                return SKShapeNode(circleOfRadius: min(cellSize.width, cellSize.height) / 4)
                
            case .big:
                return SKShapeNode(circleOfRadius: min(cellSize.width, cellSize.height) / 2 - 5)
                
            }
        }
        
        while ballsAdded < ballsNeded {
            let randomRow = Int.random(in: 0..<gridSize)
            let randomCol = Int.random(in: 0..<gridSize)
            let nodeName = "cell\(randomCol)_\(randomRow)"
            
            if let cell = childNode(withName: nodeName) as? SKSpriteNode {
                // Проверяем, есть ли шарик в ячейке
                if cell.children.isEmpty {
                    // Добавляем шарик
                    let ball = ballInit
                    ball.fillColor = randomColor()
                    ball.position = cell.position
                    ball.name = "ball"
                    addChild(ball)
                    
                    if size == .small {
                        addPanGesture()
                    }
                    
                    ballsAdded += 1
                }
            }
        }
    }
    
       
    
}

extension GameScene {
    // Добавление жеста перемещения к сцене
    func addPanGesture() {
        guard let skView = self.view else {
            return
        }

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        skView.addGestureRecognizer(panGesture)
        }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            // Получаем местоположение касания
            let touchLocation = gesture.location(in: self.view)
            
            // Проверяем, попали ли в какой-то из маленьких шариков
            let nodes = self.nodes(at: touchLocation)
            for node in nodes {
                if node.name == "ball" {
                    // Если попали, сохраняем ссылку на шарик
                    selectedBall = node as? SKShapeNode
                    return
                }
            }
        case .changed:
            guard let selectedBall = selectedBall else { return }
            
            // Получаем смещение жеста
            let translation = gesture.translation(in: self.view)
            // Смещаем позицию шарика
            selectedBall.position.x += translation.x
            selectedBall.position.y -= translation.y
            // Сбрасываем смещение жеста
            gesture.setTranslation(.zero, in: self.view)
        default:
            break
        }
    }

}



//extension GameScene {
//    // Обработка начала касания для перемещения шарика
//    // Обработка начала касания для перемещения шарика
//     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//         guard let touch = touches.first else { return }
//         let touchLocation = touch.location(in: self)
//         
//         // Проверяем, попали ли в какой-то из маленьких шариков
//         let nodes = self.nodes(at: touchLocation)
//         for node in nodes {
//             if node.name == "ball" {
//                 // Если попали, сохраняем ссылку на шарик
//                 selectedBall = node as? SKShapeNode
//                 return
//             }
//         }
//     }
//     
//     // Обработка перемещения пальца для перемещения шарика
//     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//         guard let touch = touches.first, let selectedBall = selectedBall else { return }
//         let touchLocation = touch.location(in: self)
//         
//         // Перемещаем шарик вместе с пальцем
//         selectedBall.position = touchLocation
//     }
//}

enum SizeOfBall{
    case small
    case big
}
