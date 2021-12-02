//
//  TictactoeFichasViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 15/11/21.
//

import UIKit

class TictactoeFichasViewController: UIViewController {
    
    var ficha1:String = "Miedo"
    var nombrePerfil:String?
    
    // Fichas del jugador 1
    @IBOutlet weak var fearToken1: UIButton!
    @IBOutlet weak var happyToken1: UIButton!
    @IBOutlet weak var sadToken1: UIButton!
    @IBOutlet weak var angerToken1: UIButton!
    @IBOutlet weak var affectionToken1: UIButton!
    
    
    @IBOutlet weak var emocionUsuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fearToken1.isSelected = true
        
        happyToken1.alpha = 0.5
        sadToken1.alpha = 0.5
        angerToken1.alpha = 0.5
        affectionToken1.alpha = 0.5
        
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
            print("ficha elegida: \(ficha1)")
        }
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: K.Segues.gamesSegues.emotionTicTacToe, sender: self)
        
    }
    
    private func obtenerFicha2() -> String{
        let ficha2random = ["Miedo", "Alegría", "Tristeza", "Enojo", "Afecto"]
        
        let ficha = ficha2random.randomElement()
        
        while ficha != ficha1{
            return ficha!
        }
        return ficha2random.randomElement()!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.gamesSegues.emotionTicTacToe{
            let destinoVC = segue.destination as! TicTacToeViewController
            destinoVC.ficha1 = ficha1
            destinoVC.ficha2 = obtenerFicha2()
            destinoVC.nombrePerfil = nombrePerfil
        }
    }
    
}
