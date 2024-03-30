//
//  GameScene.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 30.03.24.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    var gridSize = 9
    var cellSize: CGSize!
    
    override func didMove(to view: SKView) {
        // Размеры сцены
        let sceneWidth = size.width
        let sceneHeight = size.height
        
        
        // Размеры сетки
        cellSize = CGSize(width: 40, height: 40)
//        = CGSize(width: sceneWidth / CGFloat(gridSize), height: sceneWidth / CGFloat(gridSize))
        
        // Создаем игровую сетку
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

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = atPoint(touchLocation)
        
        // Если коснулись пустой ячейки, добавляем шарик
        if touchedNode.name?.hasPrefix("cell") == true {
            addOrRemoveBall(at: touchedNode.position)
        }
    }
    
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
    
    func randomColor() -> UIColor {
        let colors: [UIColor] = [.red, .blue, .green, .yellow]
        return colors.randomElement() ?? .white
    }
}

