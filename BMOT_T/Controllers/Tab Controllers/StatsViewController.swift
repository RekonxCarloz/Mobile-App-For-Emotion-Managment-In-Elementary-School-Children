//
//  StatsViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import Charts

class StatsViewController: UIViewController {

    var ref_database = Database.database().reference()
    var nombrePerfil:String?
    var total_partidas = 0
    
    
    //Variable de las partidas de Sopa de Letras
    var partidas_juego_SL = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    //Variable de las partidas de Memorama
    var partidas_juego_M = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    //Variable de las partidas de Pizza de emociones
    var partidas_juego_PE = 0
    
    //Variable de las partidas de Gato de emociones
    var partidas_juego_GE = 0
//
//    var partidas_emociones = [
//        "Miedo"     :   0,
//        "Afecto"    :   0,
//        "Tristeza"  :   0,
//        "Enojo"     :   0,
//        "Alegria"   :   0,
//        "Total"     :   0
//
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        self.consulta_sopaletras()
        self.consulta_memorama()
        self.consulta_gatoemociones()
        self.consulta_pizzaemociones()
        //self.prueba()
       
    }
    
    @IBAction func actualizardatosAction(_ sender: UIButton) {
        consulta_sopaletras()
        consulta_memorama()
        consulta_gatoemociones()
        consulta_pizzaemociones()
        
    }
    
    @IBAction func mostrardatosAction(_ sender: UIButton) {
        informacion_consulta()
        calculo_num_partidas()
    }
    
    @IBAction func MenuJuegosAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.stadictToMenuJuegos, sender: self)
        
    }
    
    //Funcion para realiazar consultas ->  Saber el numero de partidas que hay en total
    //consulta_sopaletras: Saber el numero de partidas que hay por cada emocion en el juego de sopa de letras.
    private func consulta_sopaletras(){
        let name_juego = "Sopa_de_Letras"
        print("Inico Partidas con miedo: \(self.partidas_juego_SL["Miedo"]!)")
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                //Consulta para saber cuantas partidas hay en la emocion de miedo
                let consulta_miedo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").queryOrdered(byChild: "partidas")
                consulta_miedo.observe(.childAdded) { (snapshot)  in
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            self.partidas_juego_SL["Miedo"]! = Int(snapshot.childrenCount)
                       
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                }
            
            //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").queryOrdered(byChild: "partidas")
                consulta_afecto.observe(.childAdded) { (snapshot)  in
                    self.partidas_juego_SL["Afecto"]! = Int(snapshot.childrenCount)
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            //dump(num)
                            //self.partidas_juego_SL["Afecto"]! = Int(snapshot.childrenCount)
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                }
            
            //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").queryOrdered(byChild: "partidas")
                consulta_tristeza.observe(.childAdded) { (snapshot)  in
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            //dump(num)
                            self.partidas_juego_SL["Tristeza"]! = Int(snapshot.childrenCount)
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
            
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            //dump(num)
                            self.partidas_juego_SL["Enojo"]! = Int(snapshot.childrenCount)
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
                    
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                            //dump(num)
                            self.partidas_juego_SL["Alegria"]! = Int(snapshot.childrenCount)
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
    //consulta_memorama: Saber el numero de partidas que hay por cada emocion en el juego de memorama.
    private func consulta_memorama(){
        let name_juego = "Memorama"
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                //Consulta para saber cuantas partidas hay en la emocion de miedo
                let consulta_miedo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Miedo").queryOrdered(byChild: "partidas")
                consulta_miedo.observe(.childAdded) { (snapshot)  in
                    
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Miedo").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Memorama")
                            self.partidas_juego_M["Miedo"]! = Int(snapshot.childrenCount)
                            //dump(self.partidas_juego_M)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                }
            
            //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto").queryOrdered(byChild: "partidas")
                consulta_afecto.observe(.childAdded) { (snapshot)  in
                    //self.partidas_juego_M["Afecto"]! = Int(snapshot.childrenCount)
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Memorama")
                            //dump(num)
                            self.partidas_juego_M["Afecto"]! = Int(snapshot.childrenCount)
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                }
            
            //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza").queryOrdered(byChild: "partidas")
                consulta_tristeza.observe(.childAdded) { (snapshot)  in
                    //self.partidas_juego_M["Tristeza"]! = Int(snapshot.childrenCount)
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Memorama")
                            //dump(num)
                            self.partidas_juego_M["Tristeza"]! = Int(snapshot.childrenCount)
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                }
                
            //Consulta para saber cuantas partidas hay en la emocion de Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo").queryOrdered(byChild: "partidas")
                consulta_enojo.observe(.childAdded) { (snapshot)  in
                    //self.partidas_juego_M["Enojo"]! = Int(snapshot.childrenCount)
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Memorama")
                            //dump(num)
                            self.partidas_juego_M["Enojo"]! = Int(snapshot.childrenCount)
                            //dump(self.partidas_emociones)
                            
                        }
                        else{
                            print("El error es: \(error!)")

                            }
                    }
                }
            //Consulta para saber cuantas partidas hay en la emocion de Alegria
                let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria").queryOrdered(byChild: "partidas")
                consulta_alegria.observe(.childAdded) { (snapshot)  in
                    //self.partidas_juego_M["Alegria"]! = Int(snapshot.childrenCount)
                        self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria").updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Memorama")
                            //dump(num)
                            self.partidas_juego_M["Alegria"]! = Int(snapshot.childrenCount)
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
    
    
    //consulta_gatoemociones: Saber el numero de partidas que hay por cada emocion en el juego de gato de emociones.
    private func consulta_gatoemociones(){
        let name_juego = "Gato_Emociones"
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                let consulta = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).queryOrdered(byChild: "partidas")
                consulta.observe(.childAdded) { (snapshot) in
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Gato")
                            //dump(num)
                            self.partidas_juego_GE = Int(snapshot.childrenCount)
                            dump(self.partidas_juego_GE)
                            
                        }else{
                            print("El error es: \(error!)")
                        }
                    }
                }
                
            }
            
        }
    }
    
    //consulta_gatoemociones: Saber el numero de partidas que hay por cada emocion en el juego de gato de emociones.
    private func consulta_pizzaemociones(){
        let name_juego = "Pizza_Emociones"
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                let consulta = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).queryOrdered(byChild: "partidas")
                consulta.observe(.childAdded) { (snapshot) in
                    self.ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).updateChildValues(["num_partidas" : snapshot.childrenCount ]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida en Pizza")
                            //dump(num)
                            self.partidas_juego_PE = Int(snapshot.childrenCount) 
                            dump(self.partidas_juego_PE)
                            
                        }else{
                            print("El error es: \(error!)")
                        }
                    }
                }
                
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    private func informacion_consulta(){
//        print("Numero de partidas miedo:\(self.partidas_juego_SL["Miedo"]!)")
//        print("Numero de partidas afecto:\(self.partidas_juego_SL["Afecto"]!)")
//        print("Numero de partidas tristeza:\(self.partidas_juego_SL["Tristeza"]!)")
//        print("Numero de partidas enojo:\(self.partidas_juego_SL["Enojo"]!)")
//        print("Numero de partidas alegria:\(self.partidas_juego_SL["Alegria"]!)")
        dump(partidas_juego_SL , name: "Sopa de Letras")
        dump(partidas_juego_M, name: "Memorama")
        dump(partidas_juego_PE, name: "PIZZA")
        dump(partidas_juego_GE, name: "gato")
    }
    
    private func calculo_num_partidas (){
        self.partidas_juego_SL["Total"] = partidas_juego_SL["Miedo"]! + partidas_juego_SL["Afecto"]! + partidas_juego_SL["Tristeza"]! + partidas_juego_SL["Enojo"]! + partidas_juego_SL["Alegria"]!
        dump(partidas_juego_SL["Total"], name: "Total Sopa")
        
        self.partidas_juego_M["Total"] = partidas_juego_M["Miedo"]! + partidas_juego_M["Afecto"]! + partidas_juego_M["Tristeza"]! + partidas_juego_M["Enojo"]! + partidas_juego_M["Alegria"]!
        dump(partidas_juego_M["Total"], name: "Total Memo")
        
        self.total_partidas = self.partidas_juego_GE + self.partidas_juego_PE + self.partidas_juego_SL["Total"]! + self.partidas_juego_M["Total"]!
        dump(total_partidas, name: "Total de partidas")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.stadictToMenuJuegos{
            let destinoVC = segue.destination as! MenuJuegosViewController
            destinoVC.nombrePerfil = nombrePerfil
        }
    }

}
