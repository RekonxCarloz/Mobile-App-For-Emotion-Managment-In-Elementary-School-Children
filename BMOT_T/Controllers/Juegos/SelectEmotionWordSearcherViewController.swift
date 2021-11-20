//
//  SelectEmotionViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 11/11/21.
//

import UIKit

class SelectEmotionWordSearcherViewController: UIViewController {
    
    var emotionSelected = ""
    var nombrePerfil:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func testButton(_ sender: UIButton) {
        if let textButton = sender.currentTitle{
           emotionSelected = textButton
            performSegue(withIdentifier: K.Segues.gamesSegues.emotionWordSearcher, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.gamesSegues.emotionWordSearcher{
            let destinoVC = segue.destination as! GameViewController
            switch emotionSelected{
            case "Miedo":
                destinoVC.emocionNum = 1
                destinoVC.nombrePerfil = nombrePerfil
            case "Alegría":
                destinoVC.emocionNum = 2
                destinoVC.nombrePerfil = nombrePerfil
            case "Tristeza":
                destinoVC.emocionNum = 3
                destinoVC.nombrePerfil = nombrePerfil
            case "Enojo":
                destinoVC.emocionNum = 4
                destinoVC.nombrePerfil = nombrePerfil
            default:
                destinoVC.emocionNum = 5
                destinoVC.nombrePerfil = nombrePerfil
            }
        }
    }
}
