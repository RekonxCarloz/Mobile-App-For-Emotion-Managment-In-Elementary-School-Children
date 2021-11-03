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
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: false)
        }
    }
    
    
    
    // MARK: - Declaration of IBActions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
