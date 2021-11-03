//
//  DatabaseManager.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import FirebaseDatabase

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
        database.child(email.safeDatabaseKey()).setValue(["username": username, "profesor": profesor]){ error, _ in
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
}
