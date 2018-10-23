//
//  ViewController.swift
//  Mineswifter
//
//  Created by iPhone on 10/21/18.
//  Copyright © 2018 iPhone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let BOARD_SIZE: Int = 10
    var board: Board
    var squareButtons:[SquareButton]=[]
    var oneSecondTimer: Timer?
    
    required init?(coder aDecoder: NSCoder) {
        self.board = Board(size: BOARD_SIZE)
        super.init(coder:aDecoder)
    }


    func initializeBoard(){
        for row in 0 ..< board.size {
            for col in 0 ..< board.size{
                let square = board.squares[row][col]
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize, squareMargin:0)
                squareButton.setTitleColor(UIColor.gray, for: .normal)
                squareButton.addTarget(self, action: #selector(squareButtonPressed(sender:)), for: .touchUpOutside)
                self.boardView.addSubview(squareButton)
                self.squareButtons.append(squareButton)
            }
        }
    }
    
    func squareButtonPressed(sender: SquareButton){
        if(!sender.square.isRevealed) {
            sender.square.isRevealed = true
            sender.setTitle("\(sender.getLabelText())", for: .normal)
            self.moves += 1
        }
        
        if sender.square.isMineLocation {
            self.minePressed()
        }
    }
    
    func minePressed() {
        self.endCurrentGame()
        let alertController = UIAlertController(title: "BOOM!", message: "You tapped on a mine.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "New Game", style: .default, handler: { action -> Void in self.startNewGame()})
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    func resetBoard() {
        // reset the board with new mine locations & sets isRevealed to false for
        self.board.resetBoard()
        // iterates through each button and reset the next to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", for: .normal)
        }
    }
    
    func startNewGame() {
        //start new Game
        self.resetBoard()
        self.timeTaken = 0
        self.moves = 0
        
        self.oneSecondTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(oneSecond), userInfo: nil, repeats: true)
    }

    func oneSecond() {
        self.timeTaken += 1
    }
    
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeBoard()
        self.startNewGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newGamePressed() {
        self.endCurrentGame()
        print("new game");
        self.startNewGame()
    }
    
    var moves: Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    
    var timeTaken: Int = 0 {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }



}

