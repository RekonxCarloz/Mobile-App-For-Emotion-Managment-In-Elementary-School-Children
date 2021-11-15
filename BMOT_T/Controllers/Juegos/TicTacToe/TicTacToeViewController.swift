//
//  TicTacToeViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 14/11/21.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    @IBOutlet weak var cell0: UIButton!
    @IBOutlet weak var cell1: UIButton!
    @IBOutlet weak var cell2: UIButton!
    @IBOutlet weak var cell3: UIButton!
    @IBOutlet weak var cell4: UIButton!
    @IBOutlet weak var cell5: UIButton!
    @IBOutlet weak var cell6: UIButton!
    @IBOutlet weak var cell7: UIButton!
    @IBOutlet weak var cell8: UIButton!
    @IBOutlet weak var turnoJugador: UILabel!
    @IBOutlet weak var winnerName: UILabel!
    
    var currentPlayer = 1
    var boardCells: [(UIButton?)] = []
    var board = [
        0,0,0,
        0,0,0,
        0,0,0
    ]
    let winPatterns = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        boardCells = [
            cell0,
            cell1,
            cell2,
            cell3,
            cell4,
            cell5,
            cell6,
            cell7,
            cell8,
        ]
        clearBoard()
        winnerName.isHidden = true
    }
    
    @IBAction func cellPressed(_ sender: UIButton) {
        let cellNumber = Int(sender.currentTitle!)!
        if board[cellNumber] == 0 {
            play(player: currentPlayer, cell: cellNumber )
        }
    }
    
    @IBAction func resetGamePressed(_ sender: UIButton) {
        clearBoard()
        winnerName.isHidden = true
    }
    
    func clearBoard (){
        board = [
            0,0,0,
            0,0,0,
            0,0,0
        ]
        turnoJugador.text = "Jugador 1"
        for cell in boardCells{
            cell!.setBackgroundImage(UIImage.init(named: "emptyCell"), for: .normal)
        }
    }
    
    func play (player:Int, cell:Int){
        board[cell] = player
        if(player == 1){
            boardCells[cell]?.setBackgroundImage(UIImage.init(named: "Enojo"), for: .normal)
            turnoJugador.text = "Jugador 2"
            
        }else{
            boardCells[cell]?.setBackgroundImage(UIImage.init(named: "Alegre"), for: .normal)
            turnoJugador.text = "Jugador 1"
            
        }
        let winner: Int? = checkWinner()
        if (winner == nil ){
            currentPlayer = changePlayer(player)
        }else{
            endGame()
        }
        print(currentPlayer)
    }
    
    func changePlayer(_ player: Int)-> Int{
        if player == 1 {
            return 2
            
        }else {
            return 1
        }
    }
    
    func checkWinner()-> Int? {
        for pattern in winPatterns{
            var cnt = 0
            for cell in pattern{
                if(board[cell] == currentPlayer){
                    cnt += 1
                }
            }
            if(cnt == 3){
                return currentPlayer
            }
            cnt = 0
        }
        return nil
    }
    
    func endGame(){
        board = [
            3,3,3,
            3,3,3,
            3,3,3
        ]
        if(currentPlayer == 1 ){
            winnerName.text = "Jugador 1 Gana!"
        }else{
            winnerName.text = "Jugador 2 Gana!"
        }
        winnerName.isHidden = false
    }
}
