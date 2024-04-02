//
//  GameCellView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 1.04.24.
//

import SwiftUI

struct GameCell: View  {
    
    @State var sizeOfCell: CGFloat
    @Binding var state: GameCellState
    
    var ballSize: CGFloat {
        switch state.size {
        case .small:
            sizeOfCell - (sizeOfCell / 2)
        case .big:
            sizeOfCell - (sizeOfCell / 5)
        }
    }
    
    var body: some View {
        
        ZStack{
            Image("CellBackground")
                .resizable()
                .frame(width: sizeOfCell,height: sizeOfCell)
                .cornerRadius(12)
            Rectangle().fill(.white).frame(width: sizeOfCell - (sizeOfCell / 10) ,height: sizeOfCell - (sizeOfCell / 10))
                .cornerRadius(12)
            
            if let color = state.color?.rawValue, state.size == .small, state.isFilled == true {
                Image(color)
                    .frame(width: ballSize, height: ballSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2))
            } else if let color = state.color?.rawValue {
                Image(color)
                    .frame(width: ballSize, height: ballSize)
                    .clipShape(Circle())
            }
        }
    }
}

enum TableType {
    case row
    case column
}

enum Balls: String {
    case pink
    case yellow
    case blue
    case green
    case purple
    case brown
    case darkBlue
    case red
}

enum SizeBall{
    case small
    case big
}

struct GameCellState: Equatable {
    var color: Balls?
    var size: SizeBall
    var isFilled: Bool
    
    init() {
        color = nil
        size = .small
        isFilled = false
    }
    
    init(color: Balls,size: SizeBall,isFilled: Bool) {
        self.color = color
        self.size = size
        self.isFilled = isFilled
    }
    
}
