//
//  AuthManager.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    // MARK: Public
    
    public func registroNuevoUsuario(username: String, email: String, password: String, profesor: Int, completion: @escaping (Bool)->Void){
        // register function
        /*
         Validar que no exista usuario o email existente
        */
        DatabaseManager.shared.disponibilidadCuenta(with: email, username: username){ canCreate in
            if canCreate{
                /*
                 Crear cuenta
                 Registrar cuenta en la base de datos
                 */
                Auth.auth().createUser(withEmail: email, password: password){
                    result, error in
                    guard error == nil, result != nil else{
                        // Firebase no pudo crear la cuenta
                        completion(false)
                        return
                    }
                    // Agregar registro a la BD
                    DatabaseManager.shared.insertarUsuarioNuevo(with: email, username: username, profesor: profesor){ inserto in
                        if inserto{
                            // Se insertó correctamente
                            completion(true)
                            return
                        }
                        else{
                            // Error en insertar nuevo usuario
                            completion(false)
                            return
                        }
                        
                    }
                }
            }
            else{
                // El usuario o email no existe
                completion(false)
            }
            
        }
    }
    
    public func loginUsuario(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if let email = email{
            // login con email
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username{
            // login con username
            
        }
    }
    
    /// Función para cerrar sesión de usuario en firebase
    public func logoutUsuario(completion: (Bool)->Void){
        do{
            try Auth.auth().signOut() // Este metodo de Auth nos permite cerrar sesion
            completion(true) // el parametro completion nos permite indicar si se completo o no la acción
            return
        }
        catch{
            print(error)
            completion(false)
            return
        }
        
    }
}
