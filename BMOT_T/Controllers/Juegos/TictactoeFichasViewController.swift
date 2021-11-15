//
//  TictactoeFichasViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 15/11/21.
//

import UIKit

class TictactoeFichasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.gamesSegues.emotionTicTacToe, sender: self)
    }
    

}
