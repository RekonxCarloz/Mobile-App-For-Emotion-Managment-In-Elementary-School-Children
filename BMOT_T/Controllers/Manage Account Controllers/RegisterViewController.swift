//
//  RegisterViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - Declaration of variables and IBOutlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var isTeacher: UISwitch!
    @IBOutlet weak var registroBoton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfTextField: UITextField!
    private var professor: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfTextField.delegate = self
        
    }
    
    
    // MARK: - Declaration of IBActions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        userTextField.resignFirstResponder()
        
        if isTeacher.isOn{
            professor = 1
        }
        
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let passwordConfirm = passwordConfTextField.text, !passwordConfirm.isEmpty,
              let username = userTextField.text, !username.isEmpty else{
                  return
              }
        if password.isEqual(passwordConfirm){
            AuthManager.shared.registroNuevoUsuario(username: username, email: email, password: password, profesor: professor){ registro in
                DispatchQueue.main.async {
                    if registro{
                        // Se registró correctamente
                        print("REGISTRO EXITOSO")
                        self.performSegue(withIdentifier: K.Segues.registerToChooseProfile, sender: self)
                    }else{
                        // Falló el registro
                    }
                }
            }
        }else{
            // Error de registro... Las contraseñas no coinciden
            let alert = UIAlertController(title: "Las contraseñas no coinciden", message: "No fue posible completar el registro", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            print(passwordTextField!)
            print(passwordConfTextField!)
        }
    }
    
    
    
    
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


extension RegisterViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField{
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            passwordConfTextField.becomeFirstResponder()
        }else{
            registerButtonPressed(registroBoton)
        }
        return true
    }
    
}
