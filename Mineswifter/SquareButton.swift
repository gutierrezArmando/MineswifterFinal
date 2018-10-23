//
//  SquareButton.swift
//  Mineswifter
//
//  Created by iPhone on 10/21/18.
//  Copyright © 2018 iPhone. All rights reserved.
//

import UIKit

class SquareButton: UIButton {

    let squareSize: CGFloat
    let squareMargin: CGFloat
    var square: Square
    
    init(squareModel: Square, squareSize:CGFloat, squareMargin: CGFloat){
        self.square = squareModel
        self.squareSize = squareSize
        self.squareMargin = squareMargin
        
        let x = CGFloat(self.square.col)*(squareSize+squareMargin)
        let y = CGFloat(self.square.row)*(squareSize+squareMargin)
        let squareFrame = CGRect(x: x, y: y, width: squareSize, height: squareSize)
        super.init(frame: squareFrame)
    }
    
    func getLabelText()->String {
        if !self.square.isMineLocation {
            if self.square.numNeighboringMines == 0 {
                // case 1: there's no mone and no neighboring mines
                return ""
            } else {
                // case 2: there's no mine but there are neighboring mines
                return "\(self.square.numNeighboringMines)"
            }
        }
        // case 3: there's a mine
        return "M"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
