//
//  TicTacToeViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 14/11/21.
//

import UIKit
import Firebase

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
    
    ///Referencia para la base de datos.
    private var dabatabase = Database.database().reference()
    var nombrePerfil:String?
    //Nombre del juego:
    private let name_juego = "Gato_Emociones"
   
    //Variables para la base de datos.
    private var fecha: String = ""
    private var duracion_partida : String = ""
    private var dateText = ""
    private var P1_emocion: String?
    private var P2_emocion: String?
    private var jugador_ganador: String?
    
    
    var ficha1 = "Miedo"
    var ficha2 = "Tristeza"
    
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
        obtener_fecha()

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
            boardCells[cell]?.setBackgroundImage(UIImage.init(named: ficha1), for: .normal)
            turnoJugador.text = "Jugador 2"
            
        }else{
            boardCells[cell]?.setBackgroundImage(UIImage.init(named: ficha2), for: .normal)
            turnoJugador.text = "Jugador 1"
            
        }
        let winner: Int? = checkWinner()
        if (winner == nil ){
            currentPlayer = changePlayer(player)
        }else{
            endGame()
            //Finaliza el juego -> Agregar la funcion de la de guardar en la base de datos
            self.P1_emocion = ficha1
            self.P2_emocion = ficha2
            
            save_game(fecha_partida: dateText, duracion_partida: "0", jugador_1: P1_emocion!, jugador_2: P2_emocion!, ganador: jugador_ganador!)
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
            jugador_ganador = winnerName.text
        }else{
            winnerName.text = "Jugador 2 Gana!"
            jugador_ganador = winnerName.text
        }
        winnerName.isHidden = false
    }
    
    //Funcion para la obtener la fecha de la partida
    private func obtener_fecha(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY.HH:mm"
        self.dateText = dateFormatter.string(from: date)
        
    }
    
    //Funcion que almacena los datos de la partida.
    private func save_game(fecha_partida: String, duracion_partida : String, jugador_1 : String, jugador_2 : String, ganador : String){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfileName = nombrePerfil {
                dabatabase.child(userEmail).child("perfiles").child(safeProfileName).child("juegos").child(name_juego).child("partidas").childByAutoId().setValue(["fecha_partida" : fecha_partida, "duracion" : duracion_partida, "jugador_1" : jugador_1 , "jugador_2" : jugador_2]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                        }
                        else{
                            print("El error es: \(error!)")
                       
                            }
                    }
            }
        }
        
    }
    
}
