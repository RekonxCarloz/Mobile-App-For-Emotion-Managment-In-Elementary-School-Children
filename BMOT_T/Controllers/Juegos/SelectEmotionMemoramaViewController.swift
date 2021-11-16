//
//  SelectEmotionMemoramaViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 12/11/21.
//

import UIKit

class SelectEmotionMemoramaViewController: UIViewController{
    var emotionSelected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emotionSelectedPressed(_ sender: UIButton) {
        if let textButton = sender.currentTitle{
            emotionSelected = textButton
            performSegue(withIdentifier: K.Segues.gamesSegues.emotionMemorama, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.gamesSegues.emotionMemorama{
            let destinoVC = segue.destination as! MemoramaViewController
            switch emotionSelected{
            case "Miedo":
                destinoVC.randomThemeIndex = 1
            case "Alegría":
                destinoVC.randomThemeIndex = 2
            case "Tristeza":
                destinoVC.randomThemeIndex = 3
            case "Enojo":
                destinoVC.randomThemeIndex = 4
            default:
                destinoVC.randomThemeIndex = 5
            }
            
        }
    }
    
}
