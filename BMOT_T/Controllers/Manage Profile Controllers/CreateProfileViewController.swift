//
//  CreateProfileViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
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
        greenColorButton.alpha = 0.4
        orangeColorButton.alpha = 0.4
        redColorButton.alpha = 0.4
        pinkColorButton.alpha = 0.4
        blueColorbutton.alpha = 0.4
    }
    //MARK: - Funciones IBActions
    @IBAction func selectColorButton(_ sender: UIButton) {
        greenColorButton.isSelected = false
        orangeColorButton.isSelected = false
        redColorButton.isSelected = false
        pinkColorButton.isSelected = false
        blueColorbutton.isSelected = false
        greenColorButton.alpha = 0.4
        orangeColorButton.alpha = 0.4
        redColorButton.alpha = 0.4
        pinkColorButton.alpha = 0.4
        blueColorbutton.alpha = 0.4
        sender.isSelected = true
        sender.alpha = 1
        colorSelected = sender.titleLabel?.text ?? "no hay valor"
        print(colorSelected)
    }
    
    
    @IBAction func crearPerfilPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: K.Segues.createProfileToHome, sender: self)
        
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
        print(avatarSelected)
    }
    
}
