//
//  Square.swift
//  Mineswifter
//
//  Created by iPhone on 10/21/18.
//  Copyright © 2018 iPhone. All rights reserved.
//

import Foundation

class Square{

    let row: Int
    let col: Int
    
    //Give these default values that we will re-assign later with each new game
    
    var numNeighboringMines = 0
    var isMineLocation = false
    var isRevealed = false
    
    init(row:Int, col:Int){
        //Store the row and column of the square in the grid
        self.row = row
        self.col = col
    }
}
