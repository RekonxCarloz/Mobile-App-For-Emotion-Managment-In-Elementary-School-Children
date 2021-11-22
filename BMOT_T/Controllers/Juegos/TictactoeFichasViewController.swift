//
//  TictactoeFichasViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 15/11/21.
//

import UIKit

class TictactoeFichasViewController: UIViewController {
    
    var ficha1:String = "Miedo"
    var ficha2:String = "Tristeza"
    var nombrePerfil:String?
    
    // Fichas del jugador 1
    @IBOutlet weak var fearToken1: UIButton!
    @IBOutlet weak var happyToken1: UIButton!
    @IBOutlet weak var sadToken1: UIButton!
    @IBOutlet weak var angerToken1: UIButton!
    @IBOutlet weak var affectionToken1: UIButton!
    
    
    // Fichas del jugador 2
    @IBOutlet weak var sadToken2: UIButton!
    @IBOutlet weak var angerToken2: UIButton!
    @IBOutlet weak var fearToken2: UIButton!
    @IBOutlet weak var happyToken2: UIButton!
    @IBOutlet weak var affectionToken2: UIButton!
    
    @IBOutlet weak var emocionUsuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fearToken1.isSelected = true
        sadToken2.isSelected = true
        
        happyToken1.alpha = 0.5
        sadToken1.alpha = 0.5
        angerToken1.alpha = 0.5
        affectionToken1.alpha = 0.5
        
        angerToken2.alpha = 0.5
        fearToken2.alpha = 0.5
        happyToken2.alpha = 0.5
        affectionToken2.alpha = 0.5
        
        emocionUsuario.text = "¿Cómo te sientes hoy, \(nombrePerfil!)?"
    }
    
    
    @IBAction func fichaElegidaPlayer1(_ sender: UIButton) {
        fearToken1.isSelected = false
        happyToken1.isSelected = false
        sadToken1.isSelected = false
        angerToken1.isSelected = false
        affectionToken1.isSelected = false
        
        fearToken1.alpha = 0.5
        happyToken1.alpha = 0.5
        sadToken1.alpha = 0.5
        angerToken1.alpha = 0.5
        affectionToken1.alpha = 0.5
        
        sender.isSelected = true
        sender.alpha = 1
        if let ficha = sender.currentTitle{
            ficha1 = String(ficha.dropLast())
            print("ficha 1: \(ficha1)")
        }
    }
    
    @IBAction func fichaElegidaPlayer2(_ sender: UIButton) {
        fearToken2.isSelected = false
        happyToken2.isSelected = false
        sadToken2.isSelected = false
        angerToken2.isSelected = false
        affectionToken2.isSelected = false
        
        fearToken2.alpha = 0.5
        happyToken2.alpha = 0.5
        sadToken2.alpha = 0.5
        angerToken2.alpha = 0.5
        affectionToken2.alpha = 0.5
        
        sender.isSelected = true
        sender.alpha = 1
        if let ficha = sender.currentTitle{
            ficha2 = String(ficha.dropLast())
            print("ficha 2: \(ficha2)")
        }
        
    }
    
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        
        if ficha1 == ficha2 {
            let alertFichas = UIAlertController(title: "Fichas iguales", message: "Escoge una ficha diferente Jugador 2", preferredStyle: .alert)
            alertFichas.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
            self.present(alertFichas, animated: true)
        }else{
            
            performSegue(withIdentifier: K.Segues.gamesSegues.emotionTicTacToe, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.gamesSegues.emotionTicTacToe{
            let destinoVC = segue.destination as! TicTacToeViewController
            destinoVC.ficha1 = ficha1
            destinoVC.ficha2 = ficha2
            destinoVC.nombrePerfil = nombrePerfil
        }
    }
    
}
