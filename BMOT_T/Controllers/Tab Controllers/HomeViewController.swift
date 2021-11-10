//
//  HomeViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var nombrePerfil:String?
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        label.text = nombrePerfil
    }
    
    

}
