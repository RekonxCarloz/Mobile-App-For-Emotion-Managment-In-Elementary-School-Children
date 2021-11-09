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
    let avatars = ["dolphinMascot", "eyesMascot", "hairyMascot", "octopusMascot", "seriousMascot"]
    var colorSelected = ""
    var avatarSelected = ""
    
    
    @IBOutlet weak var edadTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var greenColorButton: UIButton!
    @IBOutlet weak var redColorButton: UIButton!
    @IBOutlet weak var orangeColorButton: UIButton!
    @IBOutlet weak var pinkColorButton: UIButton!
    @IBOutlet weak var blueColorbutton: UIButton!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = 40
        pickerView.delegate = self
        pickerView.dataSource = self
        greenColorButton.alpha = 0.5
        orangeColorButton.alpha = 0.5
        redColorButton.alpha = 0.5
        pinkColorButton.alpha = 0.5
        blueColorbutton.alpha = 0.5
    }
    //MARK: - Funciones IBActions
    @IBAction func selectColorButton(_ sender: UIButton) {
        greenColorButton.isSelected = false
        orangeColorButton.isSelected = false
        redColorButton.isSelected = false
        pinkColorButton.isSelected = false
        blueColorbutton.isSelected = false
        greenColorButton.alpha = 0.5
        orangeColorButton.alpha = 0.5
        redColorButton.alpha = 0.5
        pinkColorButton.alpha = 0.5
        blueColorbutton.alpha = 0.5
        sender.isSelected = true
        sender.alpha = 1
        colorSelected = sender.titleLabel?.text ?? "No se elegió color"
        print(colorSelected)
    }
    
    
    @IBAction func crearPerfilPressed(_ sender: UIButton) {
        if let name = nameTextField.text, let edad = edadTextField.text{
            DatabaseManager.shared.insertarPerfilNuevo(with: name, edad: Int(edad) ?? 0, color: colorSelected, avatar: avatarSelected){ success in
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
