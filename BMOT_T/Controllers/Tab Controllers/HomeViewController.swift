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
    var mascotName = "Rick"
    var ref = Database.database().reference()
    
    @IBOutlet weak var globo2: UIView!
    @IBOutlet weak var presentMascot: UILabel!
    
    @IBOutlet weak var avatarSelected: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.hidesBackButton = true
        loadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func loadData(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfileName = nombrePerfil {
                ref.child(userEmail).child("perfiles").child(safeProfileName).observe(.value){ snapshot in
                    
                    let dict = snapshot.value as! [String: Any]
                    let nombre = dict["nombre"] as? String ?? ""
                    let avatar = dict["avatar"] as? String ?? ""
                    self.welcomeLabel.text = "Hola, \(nombre)!"
                    self.avatarSelected.image = UIImage(named: avatar)
                }
            }
        }
        
        presentMascot.text = "Yo soy \(mascotName). Hoy vamos a conocer más sobre las emociones."
        globo2.layer.cornerRadius = 20
        
    }
    
}
