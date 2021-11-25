//
//  GraficasSopaLetrasViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 24/11/21.
//

import UIKit
import Charts
import Firebase

class GraficasSopaLetrasViewController: UIViewController {
    //Varaibles para necesarias para realizar la consulta
    var nombrePerfil:String?
    var ref_database = Database.database().reference()
    let name_juego = "Sopa_de_Letras"
    
    //Variable de las partidas de Sopa de Letras por emociones
    var partidas_emociones = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    
    //Variable de las partidas de Sopa de Letras por semaforo
    var partidas_semaforo = [
        "Rojo"     :   0,
        "Amarillo" :   0,
        "Verde"    :   0
    ]
    
    var partidas_emociones_rojo = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    var partidas_emociones_amarillo = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    var partidas_emociones_verde = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    //Variable:
    var bandera = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)
        consulta_partidasemociones()
        consulta_partidassemaforo()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mostrarPartidastotales(_ sender: UIButton) {
        creacionGraficaemociones()
        dump(partidas_emociones, name: "Partidas por emocion")
        
    }
    
    @IBAction func mostrarPartidassemaforo(_ sender: UIButton) {
        creacionGraficasemaforo()
        
    }
    
    
//MARK: Consultas para cada uno de las graficas:
    //Consulta para mostrar los datos de todas las partidas:
    private func consulta_partidasemociones(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                //Consulta para saber cuantas partidas hay en la emocion de miedo
                let consulta_miedo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo")
                consulta_miedo.observe(DataEventType.value) { (snapshot)  in
                    
                    let dict = snapshot.value as! [String : Any]
                    let miedo = dict["num_partidas"] as? Int ?? 0
                    self.partidas_emociones["Miedo"]! = miedo
                    dump(self.partidas_emociones["Miedo"]!, name: "Miedo")
                    
                }
                
                //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto")
                    consulta_afecto.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let afecto = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Afecto"]! = afecto
                        dump(self.partidas_emociones["Afecto"]!)
                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza")
                    consulta_tristeza.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let tristeza = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Tristeza"]! = tristeza
                        dump(self.partidas_emociones["Tristeza"]!)
                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo")
                    consulta_enojo.observe(DataEventType.value) { (snapshot)  in

                        let dict = snapshot.value as! [String : Any]
                        let enojo = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Enojo"]!  = enojo
                            dump(self.partidas_emociones["Enojo"]! )
                        
                    
                        }
                
                //Consulta para saber cuantas partidas hay en la emocion de Alegria
                    let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria")
                consulta_alegria.observe(DataEventType.value) { (snapshot)  in
                        
                    let dict = snapshot.value as! [String : Any]
                    let alegria = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Alegria"]! = alegria
                        dump(self.partidas_emociones["Alegria"]! )
                    
                    }
            }
        }
    }
    
    
    private func creacionGraficaemociones(){
        consulta_partidasemociones()
        dump(partidas_emociones, name: "Dictionario_total")
        //Creacion de grafica de barras
        let barGrafica = BarChartView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.size.width,
                                                    height: view.frame.size.width))
        
        //Configuracion ejes
//        let xAxis = barGrafica.xAxis
//        let yAxis = barGrafica.rightAxis
        
        //Configuracion legend
        
        //Supply data
        var entradas = [BarChartDataEntry]()
        entradas.append(BarChartDataEntry(
            x: Double(1),
            y: Double( self.partidas_emociones["Miedo"]! )))
        
        entradas.append(BarChartDataEntry(
            x: Double(2),
            y: Double( self.partidas_emociones["Afecto"]! )))
        
        entradas.append(BarChartDataEntry(
            x: Double(3),
            y: Double( self.partidas_emociones["Tristeza"]! )))
        
        entradas.append(BarChartDataEntry(
            x: Double(4),
            y: Double( self.partidas_emociones["Enojo"]! )))
        
        entradas.append(BarChartDataEntry(
            x: Double(5),
            y: Double( self.partidas_emociones["Alegria"]! )))
        
        let set = BarChartDataSet(entries: entradas, label: "Partidas")
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        barGrafica.data = data
        
        if bandera == false {
            view.willRemoveSubview(barGrafica)
            view.addSubview(barGrafica)
            barGrafica.center = view.center
            
        }else{
            view.willRemoveSubview(barGrafica)
            view.addSubview(barGrafica)
            barGrafica.center = view.center
        }
        
    }
    
    
    
    private func consulta_partidassemaforo(){
        
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
            //Consulta para saber cuantas partidas hay con "semamfor rojo"
                //Emocion: miedo
                let consulta_miedo_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                consulta_miedo_rojo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_rojo["Miedo"] = Int(snapshot.childrenCount)
                }
                //Emocion: afecto
                let consulta_afecto_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                consulta_afecto_rojo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_rojo["Afecto"] = Int(snapshot.childrenCount)
                }
                //Emocion: tristeza
                let consulta_tristeza_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                consulta_tristeza_rojo.observe(.value) { (snapshot) in
                    let dict = snapshot.value as! [String : Any]
                    let color = dict["Color_Semafor"] as? String ?? ""
                    if(color == "Rojo"){
                        self.partidas_emociones_rojo["Tristeza"]! += 1
                    }
                   
                    
                }
                
                //Emocion: enojo
                let consulta_enojo_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                consulta_enojo_rojo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_rojo["Enojo"] = Int(snapshot.childrenCount)
                }

                
                //Emocion: alegria
                let consulta_alegria_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                consulta_alegria_rojo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_rojo["Alegria"] = Int(snapshot.childrenCount)
                }
            //Consulta para saber cuantas partidas hay con "semamfor Amarillo"
                //Emocion: miedo
                let consulta_miedo_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                consulta_miedo_amarillo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_amarillo["Miedo"] = Int(snapshot.childrenCount)
                }
                //Emocion: afecto
                let consulta_afecto_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                consulta_afecto_amarillo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_amarillo["Afecto"] = Int(snapshot.childrenCount)
                }
                //Emocion: tristeza
                let consulta_tristeza_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                consulta_tristeza_amarillo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_amarillo["Tristeza"] = Int(snapshot.childrenCount)
                }
                
                //Emocion: tristeza
                let consulta_enojo_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                consulta_enojo_amarillo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_amarillo["Tristeza"] = Int(snapshot.childrenCount)
                }
                
                //Emocion: alegria
                let consulta_alegria_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                consulta_alegria_amarillo.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_amarillo["Alegria"] = Int(snapshot.childrenCount)
                }
            //Consulta para saber cuantas partidas hay con "semamfor Verde"
                //Emocion: miedo
                let consulta_miedo_verder = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                consulta_miedo_verder.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_verde["Miedo"] = Int(snapshot.childrenCount)
                }
                //Emocion: afecto
                let consulta_afecto_verder = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                consulta_afecto_verder.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_verde["Afecto"] = Int(snapshot.childrenCount)
                }
                //Emocion: tristeza
                let consulta_tristeza_verder = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                consulta_tristeza_verder.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_verde["Tristeza"] = Int(snapshot.childrenCount)
                }
                
                //Emocion: enojo
                let consulta_enojo_verder = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                consulta_enojo_verder.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_verde["Enojo"] = Int(snapshot.childrenCount)
                }
                
                //Emocion: alegria
                let consulta_alegria_verder = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                consulta_alegria_verder.observe(.childAdded) { (snapshot) in
                    self.partidas_emociones_verde["Alegria"] = Int(snapshot.childrenCount)
                }
            }
        }
    }
    
    private func calculo_semaforo(){
        dump(partidas_emociones_rojo, name: "Semaforo Rojo")
        dump(partidas_emociones_amarillo, name: "Semaforo Amarillo")
        dump(partidas_emociones_verde, name: "Semaforo Verde")
//        self.partidas_semaforo["Rojo"] = partidas_emociones_rojo["Miedo"]! + partidas_emociones_rojo["Afecto"]! + partidas_emociones_rojo["Tristeza"]! + partidas_emociones_rojo["Enojo"]! + partidas_emociones_rojo["Alegria"]!
//
//        self.partidas_semaforo["Amarillo"] = partidas_emociones_amarillo["Miedo"]! + partidas_emociones_amarillo["Afecto"]! + partidas_emociones_amarillo["Tristeza"]! + partidas_emociones_amarillo["Enojo"]! + partidas_emociones_amarillo["Alegria"]!
//
//        self.partidas_semaforo["Verde"] = partidas_emociones_verde["Miedo"]! + partidas_emociones_verde["Afecto"]! + partidas_emociones_verde["Tristeza"]! + partidas_emociones_verde["Enojo"]! + partidas_emociones_verde["Alegria"]!
        
    }
    
    private func creacionGraficasemaforo(){
        consulta_partidassemaforo()
        calculo_semaforo()
        //Creacion de grafica de barras
        let barGrafica = BarChartView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.size.width,
                                                    height: view.frame.size.width))
        
        //Configuracion ejes
        //let xAxis = barGrafica.xAxis
        //let yAxis = barGrafica.rightAxis
        
        //Configuracion legend
        
        //Supply data
        var entradas = [BarChartDataEntry]()
        entradas.append(BarChartDataEntry(
            x: Double(1),
            y: Double( self.partidas_semaforo["Rojo"]! )))
        
        entradas.append(BarChartDataEntry(
            x: Double(2),
            y: Double( self.partidas_semaforo["Amarillo"]! )))
        
        entradas.append(BarChartDataEntry(
            x: Double(3),
            y: Double( self.partidas_semaforo["Verde"]! )))
        
        entradas.append(BarChartDataEntry(x: Double(4), y: Double(2), data:"Pruebax" ))
        
        
        let set = BarChartDataSet(entries: entradas, label: "Partidas")
        set.colors = ChartColorTemplates.liberty()
        let data = BarChartData(dataSet: set)
        barGrafica.data = data
        
        if bandera == false {
            view.willRemoveSubview(barGrafica)
            view.addSubview(barGrafica)
            barGrafica.center = view.center
            
        }else{
            view.willRemoveSubview(barGrafica)
            view.addSubview(barGrafica)
            barGrafica.center = view.center
        }
        
    }
    
    

}
