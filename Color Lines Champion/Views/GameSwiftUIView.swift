//
//  GameSwiftUIView.swift
//  Color Lines Champion
//
//  Created by lelya.rumynin@gmail.com on 31.03.24.
//

import SwiftUI
import UIKit

struct GameSwiftUIView: View {
    let screen: CGFloat = (UIScreen.main.bounds.size.width / 9) - 5
    @State private var presentSettings = false
    @State private var presentLose = false
    
    @State private var cellsState: [[GameCellState]] = Array(repeating: Array(repeating: GameCellState(), count: 9), count: 9)
    @State private var cellIsSelected: GameCellState? = nil
    
    @State private var score: Int = 0
    @State private var bestScore: Int = 0
    
    @State private var vibrationBool: Bool = true
    @State private var soundBool: Bool = true
    
    @State private var audio = Audio()
    @State private var vibration = Vibration()
    
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
                        .padding(.top,48)
                    Spacer()
                }
                .padding(.bottom,100)
                
                HStack{
                    Text("Score: \(score)")
                        .font(.custom("MultiroundPro", size: 20))
                        .foregroundColor(Color("ScoreYellow"))
                    Spacer()
                    Text("Best score: \(score)")
                        .font(.custom("MultiroundPro", size: 20))
                        .foregroundColor(Color("ScoreYellow"))
                    
                }.padding(.all,16)
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 9), spacing: 2) {
                    ForEach(cellsState.indices, id: \.self) { rowIndex in
                        ForEach(self.cellsState[rowIndex].indices, id: \.self) { columnIndex in
                            
                            Button(action: {
                                
                                if  cellsState[rowIndex][columnIndex].color != nil {
                                    handleCellSelection(rowIndex: rowIndex, columnIndex: columnIndex)
                                    
                                }
                                
                                if cellIsSelected == nil {
                                    handleCellSelection(rowIndex: rowIndex, columnIndex: columnIndex)
                                } else {
                                    moveSelectedCell(rowIndex: rowIndex, columnIndex: columnIndex)
                                    if checkForWinner() {
                                        print("5 шаров")
                                    }
                                }
                            }){
                                GameCell(sizeOfCell: self.screen, state: self.$cellsState[rowIndex][columnIndex]).id(rowIndex * 10 + columnIndex)
                            }
                        }
                    }
                    
                }.padding(.horizontal, 16)
                Spacer()
                
            }
            if presentSettings == true {
                SettingsView(isPresented: $presentSettings,vibrationToggle: $vibrationBool,soundToggle: $soundBool)
            }
            
            if presentLose == true {
                WinLoseView(typeOfView: .lose, score: $score, bestScore: $bestScore, presentView: $presentLose)
            }
            
        }.ignoresSafeArea()
            .onAppear {
                createBalls(size: .big)
                createBalls(size: .small)
            }
    }
    
    private func handleCellSelection(rowIndex: Int, columnIndex: Int) {
        guard cellsState[rowIndex][columnIndex].size == .small else { return }

        // Если второй раз нажато на ту же ячейку, сбрасываем выделение
        if let selectedCell = cellIsSelected, selectedCell == cellsState[rowIndex][columnIndex] {
            cellIsSelected = nil
            // Сбрасываем isFilled на всех ячейках, кроме выбранной
            for i in 0..<cellsState.count {
                for j in 0..<cellsState[i].count {
                    if !(i == rowIndex && j == columnIndex) {
                        cellsState[i][j].isFilled = false
                    }
                }
            }
            return
        }

        for i in 0..<cellsState.count {
            for j in 0..<cellsState[i].count {
                cellsState[i][j].isFilled = false
            }
        }

        cellsState[rowIndex][columnIndex].isFilled = true
        cellIsSelected = cellsState[rowIndex][columnIndex]
    }

    
    private func moveSelectedCell(rowIndex: Int, columnIndex: Int) {
        guard cellsState[rowIndex][columnIndex].color == nil else { return }
        
        for (row, rowCells) in cellsState.enumerated() {
            if let column = rowCells.firstIndex(where: { $0 == cellIsSelected }) {
                cellsState[row][column].color = nil
                break
            }
        }
        
        for (row, rowCells) in cellsState.enumerated() {
            for (column, cell) in rowCells.enumerated() {
                if cell.size == .small {
                    cellsState[row][column].size = .big
                }
            }
        }
        
        cellIsSelected?.isFilled = false
        cellIsSelected?.size = .big
        cellsState[rowIndex][columnIndex] = cellIsSelected ?? GameCellState()
        cellIsSelected = nil
        
        createBalls(size: .small)
    }
    
    private func createBalls(size: SizeBall) {
        let quantityNeedToCreate: Int = {
            switch size {
            case .small:
                return 3
            case .big:
                return 5
            }
        }()
        
        let colors: [Balls] = Balls.allCases.shuffled()
        
        var attempts = 0
        
        for (index, color) in colors.enumerated() {
            if index == quantityNeedToCreate {
                break
            }
            var randomRow = Int.random(in: 0..<9)
            var randomColumn = Int.random(in: 0..<9)
            
            while (cellsState[randomRow][randomColumn].color != nil) && (attempts < 100) {
                randomRow = Int.random(in: 0..<9)
                randomColumn = Int.random(in: 0..<9)
                attempts += 1
            }
            cellsState[randomRow][randomColumn] = GameCellState(color: color, size: size, isFilled: false)
            
            if attempts >= 100 {
                print("Не удалось создать новый шарик.")
                presentLose.toggle()
            }
        }
    }
    
    private func checkRowForWin(rowIndex: Int) -> Bool {
        let rowCells = cellsState[rowIndex]
        
        for columnIndex in 0..<rowCells.count - 4 {
            let firstColor = rowCells[columnIndex].color
            
            if firstColor != nil &&
                firstColor == rowCells[columnIndex + 1].color &&
                firstColor == rowCells[columnIndex + 2].color &&
                firstColor == rowCells[columnIndex + 3].color &&
                firstColor == rowCells[columnIndex + 4].color {
                removeWinningBalls(rowIndex: rowIndex, columnIndex: columnIndex, tableType: .row)
                score += 5
                if score > bestScore {
                    bestScore = score
                }
                return true
            }
        }
        return false
    }
    
    private func checkColumnForWin(columnIndex: Int) -> Bool {
        for rowIndex in 0..<cellsState.count - 4 {
            let firstColor = cellsState[rowIndex][columnIndex].color
            
            if firstColor != nil &&
                firstColor == cellsState[rowIndex + 1][columnIndex].color &&
                firstColor == cellsState[rowIndex + 2][columnIndex].color &&
                firstColor == cellsState[rowIndex + 3][columnIndex].color &&
                firstColor == cellsState[rowIndex + 4][columnIndex].color {
                
                removeWinningBalls(rowIndex: rowIndex, columnIndex: columnIndex, tableType: .column)
                score += 5
                return true
            }
        }
        
        return false
    }
    
    private func removeWinningBalls(rowIndex: Int, columnIndex: Int,tableType: TableType) {
        
        switch tableType {
        case .row:
            for i in 0..<5 {
                cellsState[rowIndex][columnIndex + i].color = nil
            }
        case .column:
            for i in 0..<5 {
                cellsState[rowIndex + i][columnIndex].color = nil
            }
            DispatchQueue.global(qos: .default).async {
                
                if vibrationBool == true {
                    vibration.vibration()
                }
                
                if soundBool == true {
                    audio.playSound()
                }
            }
        }
    }
    
    private func checkForWinner() -> Bool {
        for rowIndex in 0..<cellsState.count {
            if checkRowForWin(rowIndex: rowIndex) {
                return true
            }
        }
        
        for columnIndex in 0..<cellsState[0].count {
            if checkColumnForWin(columnIndex: columnIndex) {
                return true
            }
        }
        return false
    }
    
}

#Preview {
    GameSwiftUIView()
}


