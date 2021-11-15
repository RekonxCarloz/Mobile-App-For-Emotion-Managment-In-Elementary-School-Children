//
//  SelectEmotionMemoramaViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 12/11/21.
//

import UIKit

class SelectEmotionMemoramaViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emotionSelected(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.gamesSegues.emotionMemorama, sender: self)
    }
}
