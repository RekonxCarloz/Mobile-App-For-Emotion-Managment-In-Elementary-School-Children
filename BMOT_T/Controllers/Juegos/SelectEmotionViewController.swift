//
//  SelectEmotionViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 11/11/21.
//

import UIKit

class SelectEmotionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func emotionPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.Games.emotionSelectedGame, sender: self)
    }
}
