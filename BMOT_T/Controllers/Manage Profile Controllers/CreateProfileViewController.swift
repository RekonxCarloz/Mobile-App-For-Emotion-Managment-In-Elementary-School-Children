//
//  CreateProfileViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase

class CreateProfileViewController: UIViewController {
    
    
    var ref = Database.database().reference()
    
    //MARK: Variables
    let avatars = ["Billy", "Coco", "Hairy", "Frankie", "Wilt"]
    var avatarSelected = ""
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = 40
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    //MARK: - Funciones IBActions
    
    
    @IBAction func crearPerfilPressed(_ sender: UIButton) {
        if let name = nameTextField.text{
            DatabaseManager.shared.insertarPerfilNuevo(with: name, avatar: avatarSelected){ success in
                if success{
                    DispatchQueue.main.async{
                        self.performSegue(withIdentifier: K.Segues.createProfileToHome, sender: self)
                    }
                }else{
                    let alert = UIAlertController(title: "Error", message: "No fue posible crear perfil", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let name = nameTextField.text{
            if segue.identifier == K.Segues.createProfileToHome{
                let tabCtrl = segue.destination as! UITabBarController
                let navCtrl = tabCtrl.viewControllers![0] as! UINavigationController
                let destinoVC = navCtrl.topViewController as! HomeViewController
                destinoVC.nombrePerfil = name
            }
        }
    }
    
    
}









// MARK: - PickerViewDelegate & DataSource
extension CreateProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return avatars.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return avatars[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        avatar.image = UIImage(named: avatars[row])
        avatarSelected = avatars[row]
    }
    
}
