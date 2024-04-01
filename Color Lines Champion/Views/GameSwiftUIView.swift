//
//  GameSwiftUIView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 31.03.24.
//

import SwiftUI

struct GameSwiftUIView: View {
    let screen: CGFloat = (UIScreen.main.bounds.size.width / 9) - 5
    @State private var presentSettings = false
    
    @State var cellsState: [[GameCellState]] = Array(repeating: Array(repeating: GameCellState(), count: 9), count: 9)
    
    var body: some View {
        ZStack{
            
            Image("BGGame")
                .resizable()
            VStack{
                
                HStack{
                    Button(action: {
                        presentSettings.toggle()
                    }){
                        Image("pause")
                            .resizable()
                            .frame(width: 48,height: 48)
                    }.padding(.leading,16)
                        .padding(.top,32)
                    Spacer()
                }
                
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 9), spacing: 2) {
                    ForEach(cellsState.indices, id: \.self) { rowIndex in
                        ForEach(self.cellsState[rowIndex].indices, id: \.self) { columnIndex in
                            GameCell(sizeOfCell: self.screen, state: self.$cellsState[rowIndex][columnIndex]).id(rowIndex * 10 + columnIndex)
                                .onTapGesture {
                                    if cellsState[rowIndex][columnIndex].size == .small {
                                        cellsState[rowIndex][columnIndex].isFilled.toggle()
                                        // нужно добавить проверку на все чтобы не выделить несколько
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
            }
            
            if presentSettings == true {
                SettingsView(isPresented: $presentSettings)
            }
            
        }.ignoresSafeArea()
            .onAppear {
                createBalls(size: .big)
                createBalls(size: .small)
            }
        
    }
    
    private func createBalls(size: SizeBall){
        let quantityNeedToCreate: Int = {
            switch size {
            case .small:
                return 3
            case .big:
                return 5
            }
        }()
        
        let colors: [Balls] = [.pink, .yellow, .blue, .green, .red, .purple, .brown, .darkBlue]
        for (index,color) in colors.enumerated() {
            if index == quantityNeedToCreate {
                break
            }
            let randomCalor = colors.randomElement()
            let randomRow = Int.random(in: 0..<9)
            let randomColumn = Int.random(in: 0..<9)
            cellsState[randomRow][randomColumn] = GameCellState(color: color, size: size, isFilled: false)
        }
    }
}

#Preview {
    GameSwiftUIView()
}

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

struct GameCellState {
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

