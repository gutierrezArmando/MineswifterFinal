//
//  Board.swift
//  Mineswifter
//
//  Created by iPhone on 10/21/18.
//  Copyright © 2018 iPhone. All rights reserved.
//

import Foundation

class Board{
    let size:Int
    //A 2d square of square cells, indexed by [row][column]
    var squares: [[Square]] = []
    
    
    init(size:Int){
        self.size = size
        
        for row in 0 ..< size {
            var squareRow:[Square] = []
            
            for col in 0 ..< size{
                let square = Square(row:row,col:col)
                squareRow.append(square)
            }
        }
    }
    
    func resetBoard(){
        //Assign mines to squares
        for row in 0 ..< size {
            for col in 0 ..< size {
                squares[row][col].isRevealed = false
                self.calculateIsMineLocationForSquare(square: squares[row][col])
            }
        }
        
        //Count number of neighboring squares
        for row in 0 ..< size{
            for col in 0 ..< size{
                self.calculateNumNeighborMinesForSquare(square:squares[row][col])
            }
        }
    }
    
    
    func calculateIsMineLocationForSquare(square:Square){
        //1 in 10 chance that each location contains a mine
        square.isMineLocation=((arc4random()%10)==0)
    }
    
    func calculateNumNeighborMinesForSquare(square: Square){
        //First get a list of adjacent squares
        let neighbors = getNeighboringSquares(square:square)
        var numNeighboringMines = 0
        
        //For each neighbor with a mine, add 1 to this square's count
        for neighborSquare in neighbors{
            if neighborSquare.isMineLocation{
                numNeighboringMines += 1
            }
        }
        square.numNeighboringMines = numNeighboringMines
        
    }
    func getNeighboringSquares(square: Square) ->[Square]{
        var neighbors: [Square] = []
        //An array of tuples containing the relative position of each neighbor to the square
        let adjacentOffsets = [(-1,-1),(0,-1),(1,-1),(-1,0),(1,0),(-1,1),(0,1),(1,1)]
        
        for (rowOffset,colOffset) in adjacentOffsets{
            //GetTitleLocation might return a Square, or it might return nil so the datatype "?"
            let optionalNeighbor:Square? = getTileAtLocation(row: square.row + rowOffset, col: square.col+colOffset)
            //Only evaluates true if the optional title isn't nil
            if let neighbor = optionalNeighbor{
                neighbors.append(neighbor)
            }
        }
        return neighbors
    }
    
    func getTileAtLocation(row: Int,col: Int) -> Square?{
        if row >= 0 && row < self.size && col >= 0 && col < self.size {
            return squares[row][col]
        } else{
            return nil
        }
    }
    
    
}
