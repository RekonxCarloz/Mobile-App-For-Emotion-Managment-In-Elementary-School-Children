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
    
    
    //Vistas
    var barGraficaemociones = BarChartView()
    var barGrafica_semaforo = BarChartView()
    
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
    var bandera = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)
        consulta_partidasemociones()
        consulta_partidassemaforo()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mostrarPartidastotales(_ sender: UIButton) {
        self.bandera = "total"
        creacionGraficas()
        barGrafica_semaforo.removeFromSuperview()
        
        
    }
    
    @IBAction func mostrarPartidassemaforo(_ sender: UIButton) {
        self.bandera = "semaforo"
        creacionGraficas()
        barGraficaemociones.removeFromSuperview()

        
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
                    //dump(self.partidas_emociones["Miedo"]!, name: "Miedo")
                    
                }
                
                //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto")
                    consulta_afecto.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let afecto = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Afecto"]! = afecto
                        //dump(self.partidas_emociones["Afecto"]!)
                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza")
                    consulta_tristeza.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let tristeza = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Tristeza"]! = tristeza
                        //dump(self.partidas_emociones["Tristeza"]!)
                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo")
                    consulta_enojo.observe(DataEventType.value) { (snapshot)  in

                        let dict = snapshot.value as! [String : Any]
                        let enojo = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Enojo"]!  = enojo
                        //dump(self.partidas_emociones["Enojo"]! )
                        
                    
                        }
                
                //Consulta para saber cuantas partidas hay en la emocion de Alegria
                    let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria")
                consulta_alegria.observe(DataEventType.value) { (snapshot)  in
                        
                    let dict = snapshot.value as! [String : Any]
                    let alegria = dict["num_partidas"] as? Int ?? 0
                    self.partidas_emociones["Alegria"]! = alegria
                    //dump(self.partidas_emociones["Alegria"]! )
                    
                    }
            }
        }
    }
    
    
    private func creacionGraficas(){
        consulta_partidasemociones()
        //dump(partidas_emociones, name: "Dictionario_total")
        
        //Creacion de grafica de barras emociones
        barGraficaemociones = BarChartView(frame: CGRect(x: 0,
                                                    y: 180,
                                                    width: view.frame.size.width,
                                                    height: 320))
        
        //Configuracion ejes
//        let xAxis = barGrafica.xAxis
//        let yAxis = barGrafica.rightAxis
        
        //Configuracion legend
        
        //Supply data
        var entrada_miedo = [BarChartDataEntry]()
        entrada_miedo.append(BarChartDataEntry(
            x: Double(1),
            y: Double( self.partidas_emociones["Miedo"]! )))
        
        var entrada_afecto = [BarChartDataEntry]()
        entrada_afecto.append(BarChartDataEntry(
            x: Double(2),
            y: Double( self.partidas_emociones["Afecto"]! )))
        
        var entrada_tristeza = [BarChartDataEntry]()
        entrada_tristeza.append(BarChartDataEntry(
            x: Double(3),
            y: Double( self.partidas_emociones["Tristeza"]! )))
        
        var entrada_ejono = [BarChartDataEntry]()
        entrada_ejono.append(BarChartDataEntry(
            x: Double(4),
            y: Double( self.partidas_emociones["Enojo"]! )))
        
        var entrada_alegria = [BarChartDataEntry]()
        entrada_alegria.append(BarChartDataEntry(
            x: Double(5),
            y: Double( self.partidas_emociones["Alegria"]! )))
        
        let set_miedo = BarChartDataSet(entries: entrada_miedo, label: "Miedo")
        set_miedo.colors = ChartColorTemplates.joyful()
        
        let set_afecto = BarChartDataSet(entries: entrada_afecto, label: "Afecto")
        set_afecto.colors = ChartColorTemplates.pastel()
        
        let set_tristeza = BarChartDataSet(entries: entrada_tristeza, label: "Tristeza")
        set_tristeza.colors = ChartColorTemplates.colorful()
        
        let set_enojo = BarChartDataSet(entries: entrada_ejono, label: "Enojo")
        set_enojo.colors = ChartColorTemplates.material()
        
        let set_alegria = BarChartDataSet(entries: entrada_alegria, label: "Alegría")
        set_alegria.colors = ChartColorTemplates.liberty()
        
        let datos_emociones = BarChartData(dataSets:[set_miedo,set_afecto,set_tristeza,set_enojo,set_alegria])
        self.barGraficaemociones.data = datos_emociones
        
        consulta_partidassemaforo()
        calculo_semaforo()
        //Creacion de grafica de barras
        barGrafica_semaforo = BarChartView(frame: CGRect(x: 0,
                                                    y: 520,
                                                    width: view.frame.size.width,
                                                         height: 320))
        
        //Configuracion ejes
        //let xAxis = barGrafica.xAxis
        //let yAxis = barGrafica.rightAxis
        
        //Configuracion legend
        
        //Supply data
        var entrada_semaforoverde = [BarChartDataEntry]()
        entrada_semaforoverde.append(BarChartDataEntry(
            x: Double(1),
            y: Double( self.partidas_semaforo["Verde"]! )))

        var entrada_semaforoamarillo = [BarChartDataEntry]()
        entrada_semaforoamarillo.append(BarChartDataEntry(
            x: Double(2),
            y: Double( self.partidas_semaforo["Amarillo"]! )))

        var entrada_semafororojo = [BarChartDataEntry]()
        entrada_semafororojo.append(BarChartDataEntry(
            x: Double(3),
            y: Double( self.partidas_semaforo["Rojo"]! )))
        
        let set_semaforoverde = BarChartDataSet(entries: entrada_semaforoverde, label: "Verde")
        set_semaforoverde.colors = ChartColorTemplates.material()
        
        let set_semaforoamarillo = BarChartDataSet(entries: entrada_semaforoamarillo, label: "Amarillo")
        set_semaforoamarillo.colors = ChartColorTemplates.pastel()
        
        let set_semafororojo = BarChartDataSet(entries: entrada_semafororojo, label: "Rojo")
        set_semafororojo.colors = ChartColorTemplates.liberty()
        
        let datos_semaforo = BarChartData(dataSets: [set_semaforoverde,set_semaforoamarillo,set_semafororojo ])
        barGrafica_semaforo.data = datos_semaforo
        //var eliminar = true
        if bandera == "total" {
           //eliminar = true
            view.addSubview(barGraficaemociones)
            //barGraficaemociones.center = view.center
            
            
        }else if bandera == "semaforo"{
           //eliminar = false
            view.addSubview(barGrafica_semaforo)
            //barGrafica_semaforo.center = view.center
            //barGraficaemociones.removeFromSuperview()
        }
       
       
        
    }
    
    
    
    private func consulta_partidassemaforo(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
            //Emocion: miedo
                let consulta_miedo_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                var cont_0 = 0
                consulta_miedo_rojo.observe(.childAdded) { (snapshot) in
                    cont_0 += 1
                    self.partidas_emociones_rojo["Miedo"] = cont_0
                }
                
                let consulta_miedo_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                var cont_1 = 0
                consulta_miedo_amarillo.observe(.childAdded) { (snapshot) in
                    cont_1 += 1
                    self.partidas_emociones_amarillo["Miedo"] = cont_1
                }
                
                let consulta_miedo_verde = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("miedo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                var cont_2 = 0
                consulta_miedo_verde.observe(.childAdded) { (snapshot) in
                    cont_2 += 1
                    self.partidas_emociones_verde["Miedo"] = cont_2
                }
            //Emocion: afecto
                let consulta_afecto_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                var cont_3 = 0
                consulta_afecto_rojo.observe(.childAdded) { (snapshot) in
                    cont_3 += 1
                    self.partidas_emociones_rojo["Afecto"] = cont_3
                }
                
                let consulta_afecto_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                var cont_4 = 0
                consulta_afecto_amarillo.observe(.childAdded) { (snapshot) in
                    cont_4 += 1
                    self.partidas_emociones_amarillo["Afecto"] = cont_4
                }
                
                let consulta_afecto_verde = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("afecto").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                var cont_5 = 0
                consulta_afecto_verde.observe(.childAdded) { (snapshot) in
                    cont_5 += 1
                    self.partidas_emociones_verde["Afecto"] = cont_5
                }
                
            //Emocion: tristeza
                let consulta_tristeza_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                var cont_6 = 0
                consulta_tristeza_rojo.observe(.childAdded) { (snapshot) in
                    cont_6 += 1
                    self.partidas_emociones_rojo["Tristeza"] = cont_6
                }
                let consulta_tristeza_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                var cont_7 = 0
                consulta_tristeza_amarillo.observe(.childAdded) { (snapshot) in
                    cont_7 += 1
                    self.partidas_emociones_amarillo["Tristeza"] = cont_7
                }
                let consulta_tristeza_verde = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                 var cont_8 = 0
                consulta_tristeza_verde.observe(.childAdded) { (snapshot) in
                    cont_8 += 1
                    self.partidas_emociones_verde["Tristeza"] = cont_8
                }
                
            //Emocion: enojo
                let consulta_enojo_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                var cont_9 = 0
                consulta_enojo_rojo.observe(.childAdded) { (snapshot) in
                    cont_9 += 1
                    self.partidas_emociones_rojo["Enojo"] = cont_9
                }
                let consulta_enojo_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("tristeza").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                var cont_10 = 0
                consulta_enojo_amarillo.observe(.childAdded) { (snapshot) in
                    cont_10 += 1
                    self.partidas_emociones_amarillo["Enojo"] = cont_10
                }
                let consulta_enojo_verde = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("enojo").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                var cont_11 = 0
                consulta_enojo_verde.observe(.childAdded) { (snapshot) in
                    cont_11 += 1
                    self.partidas_emociones_verde["Enojo"] = cont_11
                }
            //Emocion: alegria
                let consulta_alegria_rojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Rojo")
                var cont_12 = 0
                consulta_alegria_rojo.observe(.childAdded) { (snapshot) in
                    cont_12 += 1
                    self.partidas_emociones_rojo["Alegria"] = cont_12
                }
                let consulta_alegria_amarillo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Amarillo")
                var cont_13 = 0
                consulta_alegria_amarillo.observe(.childAdded) { (snapshot) in
                    cont_13 += 1
                    self.partidas_emociones_amarillo["Alegria"] = cont_13
                }
                let consulta_alegria_verde = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("alegria").child("partidas").queryOrdered(byChild: "Color_Semaforo").queryEqual(toValue: "Verde")
                var cont_14 = 0
                consulta_alegria_verde.observe(.childAdded) { (snapshot) in
                    cont_14 += 1
                    self.partidas_emociones_verde["Alegria"] = cont_14
                }
                
            }
        }
    }
    
    private func calculo_semaforo(){
//        dump(partidas_emociones_rojo, name: "Semaforo Rojo")
//        dump(partidas_emociones_amarillo, name: "Semaforo Amarillo")
//        dump(partidas_emociones_verde, name: "Semaforo Verde")
        self.partidas_semaforo["Rojo"] = partidas_emociones_rojo["Miedo"]! + partidas_emociones_rojo["Afecto"]! + partidas_emociones_rojo["Tristeza"]! + partidas_emociones_rojo["Enojo"]! + partidas_emociones_rojo["Alegria"]!

        self.partidas_semaforo["Amarillo"] = partidas_emociones_amarillo["Miedo"]! + partidas_emociones_amarillo["Afecto"]! + partidas_emociones_amarillo["Tristeza"]! + partidas_emociones_amarillo["Enojo"]! + partidas_emociones_amarillo["Alegria"]!

        self.partidas_semaforo["Verde"] = partidas_emociones_verde["Miedo"]! + partidas_emociones_verde["Afecto"]! + partidas_emociones_verde["Tristeza"]! + partidas_emociones_verde["Enojo"]! + partidas_emociones_verde["Alegria"]!
        
    }
    
}
