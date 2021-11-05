//
//  DatabaseManager.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import FirebaseDatabase
import FirebaseAuth

public class DatabaseManager{
    static let shared = DatabaseManager()
    // Referencia a la base de datos
    private let database = Database.database().reference()
    
    // MARK: Public
    /// Verifica si el usuario o email estan disponibles
    /// - Parameters
    ///     - Email: email
    ///     - Username: usuario
    
    public func disponibilidadCuenta(with email: String, username: String, completion: (Bool)-> Void){
        completion(true)
    }
    
    
    /// Insertar nuevo usuario
    /// - Parameters
    ///     Email: email
    ///     Username: usuario
    ///     Completion: llamada asincrona si la entrada en base de datos se ejecutó correctamente
    public func insertarUsuarioNuevo(with email: String, username: String, profesor: Int, completion: @escaping (Bool)->Void){
        database.child(email.safeDatabaseKey()).setValue(["username": username, "profesor": profesor, "perfiles": []]){ error, _ in
            if error == nil {
                completion(true)
                return
            }
            else{
                completion(false)
                return
            }
        }
    }
    
    /// Insertar nuevo perfil
    ///  - Parameters
    ///
    public func insertarPerfilNuevo(with nombre: String, edad: Int, color: String, avatar: String, completion: @escaping (Bool)->Void){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            database.child(userEmail).child("perfiles").child(nombre).setValue(["nombre": nombre, "edad": edad, "color": color, "avatar": avatar]){ error, _ in
                if error == nil{
                    completion(true)
                    return
                }
                else{
                    print("-------------------------------------- El error es: \(error?.localizedDescription)")
                    completion(false)
                    return
                }
            }
        }
        
        
    }

}
