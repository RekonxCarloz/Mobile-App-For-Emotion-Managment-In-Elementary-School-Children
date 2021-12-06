//
//  BmotViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase
import Kommunicate

class BmotViewController: UIViewController {
    ///Referencia para la base de datos.
    private var ref_dabatabase = Database.database().reference()
    var nombrePerfil:String?
    var correo: String = ""
    var nombre: String = ""
  
    //Creacion de un objeto para el chatbot
    let kmUser = KMUser()
    let botId = "bmot-mcbil"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtener_datos()
        navigationItem.hidesBackButton = true
    }
    
    /*
    // MARK: - Funcione para mostra el chat bot:
    /// Esta función mostrara un
    */
    @IBAction func mostrarBotAction(_ sender: UIButton) {
        obtener_datos()
        self.kmUser.userId = nombre
        self.kmUser.email = correo
        self.kmUser.displayName = nombre
        self.kmUser.applicationId = "30fc55ae2d136c4afe1f7a5e960138b8"
        Kommunicate.registerUser(self.kmUser, completion: {
            response, error in
            guard error == nil else {return}
            //print("Success")
            if Kommunicate.isLoggedIn {
                let kmConversation = KMConversationBuilder().withBotIds([self.botId])
                    .useLastConversation(false)
                    .build()
                Kommunicate.createConversation(conversation: kmConversation) { result in
                    switch result {
                    case .success(let conversationId):
                        print("Conversation id: ",conversationId)
                        Kommunicate.defaultConfiguration.hideFaqButtonInConversationList = true
                        Kommunicate.defaultConfiguration.hideFaqButtonInConversationView = true
                        Kommunicate.defaultConfiguration.chatBar.optionsToShow = .none
                        Kommunicate.defaultConfiguration.hideAudioOptionInChatBar = true
                        Kommunicate.showConversationWith(
                            groupId: conversationId,
                            from: self,
                            showListOnBack: false,
                            completionHandler: { success in
                            print("conversation was shown")
                        })
                    // Launch conversation
                    case .failure(let kmConversationError):
                        print("Fallo en creación de la conversación: ", kmConversationError)
                    }
                }
            
            }
            
            
        })
        
    }
    
    //Función
    private func obtener_datos(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfileName = nombrePerfil {
                ref_dabatabase.child(userEmail).child("perfiles").child(safeProfileName).observe(.value){ snapshot in
                    let dict = snapshot.value as! [String: Any]
                    let nombre = dict["nombre"] as? String ?? ""
                    self.correo = userEmail
                    self.nombre = nombre
                }
            }
        }
    }
    

}
