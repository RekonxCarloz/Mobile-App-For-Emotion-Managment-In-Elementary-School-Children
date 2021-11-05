//
//  LoginViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - Declaration of variables and IBOutlets

    @IBOutlet weak var emailUserTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Life App Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleNotAuthenticated()
        // Do any additional setup after loading the view.
    }
    
    private func handleNotAuthenticated(){
        if Auth.auth().currentUser != nil{
            // Log in
            self.performSegue(withIdentifier: K.Segues.loginToChooseProfile, sender: self)
        }
    }
    
    
    
    // MARK: - Declaration of IBActions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let usernameEmail = emailUserTextField.text, !usernameEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else{
                return
        }
        
        var email: String?
        var username: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            email = usernameEmail
        }else{
            username = usernameEmail
        }
        
        AuthManager.shared.loginUsuario(username: username,email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // Si se logra el login de usuario
                    self.performSegue(withIdentifier: K.Segues.loginToChooseProfile, sender: self)
                }
                else{
                    // Error de autenticación
                    let alert = UIAlertController(title: "Error", message: "No fue posible iniciar sesión", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
        
    }

}


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailUserTextField{
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField{
            loginButtonPressed(loginButton)
        }
        return true
    }
}
