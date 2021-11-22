//
//  JuegosViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit

class JuegosViewController: UIViewController {

    var nombrePerfil:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    
    
    @IBAction func wordSearcherButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.wordSearcherGameToEmotions, sender: self)
    }
    
    
    @IBAction func memoramaButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.memoramaGameToEmotions, sender: self)
    }
    
    
    @IBAction func tictactoeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.ticTacToeGameToEmotions, sender: self)
    }
    
    @IBAction func pizzaButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.pizzaGameSegue, sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.wordSearcherGameToEmotions{
            let vc = segue.destination as! SelectEmotionWordSearcherViewController
            vc.nombrePerfil = nombrePerfil
            
        }else if segue.identifier == K.Segues.memoramaGameToEmotions{
            let vc = segue.destination as! SelectEmotionMemoramaViewController
            vc.nombrePerfil = nombrePerfil
            
        }else if segue.identifier == K.Segues.ticTacToeGameToEmotions{
            let vc = segue.destination as! TictactoeFichasViewController
            vc.nombrePerfil = nombrePerfil
            
        }else if segue.identifier == K.Segues.pizzaGameSegue{
            let vc = segue.destination as! PizzaGameViewController
            vc.nombrePerfil = nombrePerfil
        }
    }
    
}
