//
//  StatsViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class StatsViewController: UIViewController {

    var ref_database = Database.database().reference()
    var nombrePerfil:String?
    let name_juego = "Sopa_de_Letras"
    var partidas_emociones = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        //self.consulta_num1()
        //self.prueba()
       
    }
    
    @IBAction func AddPartidas(_ sender: UIButton) {
        consulta_num1()
        
    }
    
    @IBAction func pruebaAction(_ sender: UIButton) {
        prueba()
    }
    

    //Funcion para realiazar consultas
    //consulta_num_1: Saber el numero de partidas que hay por cada emocion en el juego de sopa de letras.
    //consulta_num_2: Saber el numero de partidas que tuvo el niño cada uno de los semaforos.
    //consulta_num_2: Saber el numero de partidas que hay en total
    private func consulta_num1(){
        var num = 0
        print("Inico Partidas con miedo: \(self.partidas_emociones["Miedo"]!)")
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                
                //Consulta para saber cuantas partidas hay en la emocion de miedo
                let consulta_miedo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").queryOrdered(byChild: "partidas")
                consulta_miedo.observe(.childAdded) { (snapshot)  in
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(self.name_juego).child("emociones").child("miedo").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            num = Int(snapshot.childrenCount)
                            dump(num)
                            self.partidas_emociones["Miedo"]! = num
                            dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                 
                
             }
            
            //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").queryOrdered(byChild: "partidas")
                consulta_afecto.observe(.childAdded) { (snapshot)  in
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(self.name_juego).child("emociones").child("afecto").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            num = Int(snapshot.childrenCount)
                            //dump(num)
                            self.partidas_emociones["Afecto"]! = num
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                 
                
             }
            
            //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").queryOrdered(byChild: "partidas")
                consulta_tristeza.observe(.childAdded) { (snapshot)  in
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(self.name_juego).child("emociones").child("afecto").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            num = Int(snapshot.childrenCount)
                            //dump(num)
                            self.partidas_emociones["Tristeza"]! = num
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                 
                
             }
                
            //Consulta para saber cuantas partidas hay en la emocion de Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo").queryOrdered(byChild: "partidas")
                consulta_enojo.observe(.childAdded) { (snapshot)  in
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(self.name_juego).child("emociones").child("enojo").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            num = Int(snapshot.childrenCount)
                            //dump(num)
                            self.partidas_emociones["Enojo"]! = num
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                 
                
             }
                
                
            //Consulta para saber cuantas partidas hay en la emocion de Alegria
                let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").queryOrdered(byChild: "partidas")
                consulta_alegria.observe(.childAdded) { (snapshot)  in
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(self.name_juego).child("emociones").child("alegria").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            num = Int(snapshot.childrenCount)
                            //dump(num)
                            self.partidas_emociones["Alegria"]! = num
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                 
                
             }
                
         
                
            }
        }
    }
    
    private func prueba(){
        print("Numero de partidas miedo:\(self.partidas_emociones["Miedo"]!)")
        print("Numero de partidas afecto:\(self.partidas_emociones["Afecto"]!)")
        print("Numero de partidas tristeza:\(self.partidas_emociones["Tristeza"]!)")
        print("Numero de partidas tristeza:\(self.partidas_emociones["Enojo"]!)")
        print("Numero de partidas tristeza:\(self.partidas_emociones["Alegria"]!)")
    }

}
