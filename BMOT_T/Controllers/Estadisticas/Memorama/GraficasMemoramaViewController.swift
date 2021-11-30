//
//  GraficasMemoramaViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 25/11/21.
//

import UIKit
import Firebase
import Charts

class GraficasMemoramaViewController: UIViewController {
    //Varaibles para necesarias para realizar la consulta
    var nombrePerfil:String?
    var ref_database = Database.database().reference()
    let name_juego = "Memorama"
    
    //Variable de las partidas de Memorama por emociones
    var partidas_emociones = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    //Variable de las partidas de memorama por puntaje
    var partidas_puntaje = [
        "Positivo"     :   0,
        "Cero"        :   0,
        "Negativo"    :   0
    ]
    
    var partidas_emociones_cero = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    var partidas_emociones_positivo = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    var partidas_emociones_negativo = [
        "Miedo"     :   0,
        "Afecto"    :   0,
        "Tristeza"  :   0,
        "Enojo"     :   0,
        "Alegria"   :   0
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)
        consulta_partidastotal()
        consulta_partidas_puntaje()

    }
    

    /*
    // MARK: - Funciones para los botones
    */
    @IBAction func mostrartotalAction(_ sender: UIButton) {
        general_grafica()
        
    }
    
    
    @IBAction func mostrarrangosAction(_ sender: UIButton) {
        general_grafica_puntaje()
        
    }
    
    //MARK: Consultas: Funciones
    
    // Consulta para mostrar los datos de todas las partidas:
    private func consulta_partidastotal(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                //Consulta para saber cuantas partidas hay en la emocion de miedo
                let consulta_miedo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Miedo")
                consulta_miedo.observe(DataEventType.value) { (snapshot)  in
                    
                    let dict = snapshot.value as! [String : Any]
                    let miedo = dict["num_partidas"] as? Int ?? 0
                    self.partidas_emociones["Miedo"]! = miedo
                    
                }
                
                //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto")
                    consulta_afecto.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let afecto = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Afecto"]! = afecto

                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza")
                    consulta_tristeza.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let tristeza = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Tristeza"]! = tristeza

                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo")
                    consulta_enojo.observe(DataEventType.value) { (snapshot)  in

                        let dict = snapshot.value as! [String : Any]
                        let enojo = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Enojo"]!  = enojo

                        
                    
                        }
                
                //Consulta para saber cuantas partidas hay en la emocion de Alegria
                    let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria")
                consulta_alegria.observe(DataEventType.value) { (snapshot)  in
                        
                    let dict = snapshot.value as! [String : Any]
                    let alegria = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Alegria"]! = alegria

                    
                    }
            }
        }
    }
    
    private func consulta_partidas_puntaje(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                //Puntaje mayor a 0
                /// Emoción: Miedo
                let consulta_miedo_positvo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Miedo").child("partidas").queryOrdered(byChild: "puntaje").queryStarting(afterValue: 0)
                var cont_p_1 = 0
                consulta_miedo_positvo.observe(.childAdded) { (snapshot) in
                    cont_p_1 += 1
                    self.partidas_emociones_positivo["Miedo"] = cont_p_1
                }
                /// Emoción: Afecto
                let consulta_afecto_positvo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto").child("partidas").queryOrdered(byChild: "puntaje").queryStarting(afterValue: 0)
                var cont_p_2 = 0
                consulta_afecto_positvo.observe(.childAdded) { (snapshot) in
                    cont_p_2 += 1
                    self.partidas_emociones_positivo["Afecto"] = cont_p_2
                }
                /// Emoción: Tristeza
                let consulta_tristeza_positvo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza").child("partidas").queryOrdered(byChild: "puntaje").queryStarting(afterValue: 0)
                var cont_p_3 = 0
                consulta_tristeza_positvo.observe(.childAdded) { (snapshot) in
                    cont_p_3 += 1
                    self.partidas_emociones_positivo["Tristeza"] = cont_p_3
                }
                /// Emoción: Enojo
                let consulta_enojo_positvo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo").child("partidas").queryOrdered(byChild: "puntaje").queryStarting(afterValue: 0)
                var cont_p_4 = 0
                consulta_enojo_positvo.observe(.childAdded) { (snapshot) in
                    cont_p_4 += 1
                    self.partidas_emociones_positivo["Enojo"] = cont_p_4
                }
                /// Emoción: Alegria
                let consulta_alegria_positvo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria").child("partidas").queryOrdered(byChild: "puntaje").queryStarting(afterValue: 0)
                var cont_p_5 = 0
                consulta_alegria_positvo.observe(.childAdded) { (snapshot) in
                    cont_p_5 += 1
                    self.partidas_emociones_positivo["Alegria"] = cont_p_5
                }
                
                //Puntaje menor a 0
                /// Emoción: Miedo
                let consulta_miedo_negativo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Miedo").child("partidas").queryOrdered(byChild: "puntaje").queryEnding(beforeValue: 0)
                var cont_n_1 = 0
                consulta_miedo_negativo.observe(.childAdded) { (snapshot) in
                    cont_n_1 += 1
                    self.partidas_emociones_negativo["Miedo"] = cont_n_1
                }
                
                /// Emoción: Afecto
                let consulta_afecto_negativo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto").child("partidas").queryOrdered(byChild: "puntaje").queryEnding(beforeValue: 0)
                var cont_n_2 = 0
                consulta_afecto_negativo.observe(.childAdded) { (snapshot) in
                    cont_n_2 += 1
                    self.partidas_emociones_negativo["Afecto"] = cont_n_2
                }
                
                /// Emoción: Tristeza
                let consulta_tristeza_negativo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza").child("partidas").queryOrdered(byChild: "puntaje").queryEnding(beforeValue: 0)
                var cont_n_3 = 0
                consulta_tristeza_negativo.observe(.childAdded) { (snapshot) in
                    cont_n_3 += 1
                    self.partidas_emociones_negativo["Tristeza"] = cont_n_3
                }
                
                /// Emoción: Enojo
                let consulta_enojo_negativo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo").child("partidas").queryOrdered(byChild: "puntaje").queryEnding(beforeValue: 0)
                var cont_n_4 = 0
                consulta_enojo_negativo.observe(.childAdded) { (snapshot) in
                    cont_n_4 += 1
                    self.partidas_emociones_negativo["Enojo"] = cont_n_4
                }
                
                /// Emoción: Alegria
                let consulta_alegria_negativo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria").child("partidas").queryOrdered(byChild: "puntaje").queryEnding(beforeValue: 0)
                var cont_n_5 = 0
                consulta_alegria_negativo.observe(.childAdded) { (snapshot) in
                    cont_n_5 += 1
                    self.partidas_emociones_negativo["Alegria"] = cont_n_5
                }
                
                //Puntaje igual a 0
                /// Emoción: Miedo
                let consulta_miedo_cero = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Miedo").child("partidas").queryOrdered(byChild: "puntaje").queryEqual(toValue: 0)
                    var cont_0 = 0
                consulta_miedo_cero.observe(.childAdded) { (snapshot) in
                        cont_0 += 1
                        self.partidas_emociones_cero["Miedo"] = cont_0
                    
                }
                /// Emoción: Afecto
                let consulta_afecto_cero = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto").child("partidas").queryOrdered(byChild: "puntaje").queryEqual(toValue: 0)
                    var cont_1 = 0
                consulta_afecto_cero.observe(.childAdded) { (snapshot) in
                        cont_1 += 1
                        self.partidas_emociones_cero["Afecto"] = cont_1
                    
                }
                /// Emoción: Tristeza
                let consulta_tristeza_cero = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza").child("partidas").queryOrdered(byChild: "puntaje").queryEqual(toValue: 0)
                    var cont_2 = 0
                consulta_tristeza_cero.observe(.childAdded) { (snapshot) in
                        cont_2 += 1
                        self.partidas_emociones_cero["Tristeza"] = cont_2
                    
                }
                /// Emoción: Enojo
                let consulta_enojo_cero = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo").child("partidas").queryOrdered(byChild: "puntaje").queryEqual(toValue: 0)
                    var cont_3 = 0
                consulta_enojo_cero.observe(.childAdded) { (snapshot) in
                        cont_3 += 1
                        self.partidas_emociones_cero["Enojo"] = cont_3
                    
                }
                /// Emoción: Alegria
                let consulta_alegria_cero = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria").child("partidas").queryOrdered(byChild: "puntaje").queryEqual(toValue: 0)
                    var cont_4 = 0
                consulta_alegria_cero.observe(.childAdded) { (snapshot) in
                        cont_4 += 1
                        self.partidas_emociones_cero["Alegria"] = cont_4
                    
                }
                
                
            }
        }
    }
    
    //MARK: Funciones
    //Funciones para general la graficas de cada uno de las consultas:
    private func general_grafica(){
        consulta_partidastotal()
        
        //Creacion de grafica de barras emociones
        let barGraficaemociones = BarChartView(frame: CGRect(x: 0,
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
        
        var entrada_enojo = [BarChartDataEntry]()
        entrada_enojo.append(BarChartDataEntry(
            x: Double(4),
            y: Double( self.partidas_emociones["Enojo"]! )))
        
        var entrada_alegria = [BarChartDataEntry]()
        entrada_alegria.append(BarChartDataEntry(
            x: Double(5),
            y: Double( self.partidas_emociones["Alegria"]! )))
        
        let set_miedo = BarChartDataSet(entries: entrada_miedo, label: "Miedo")
        set_miedo.colors = ChartColorTemplates.material()
        
        let set_afecto = BarChartDataSet(entries: entrada_afecto, label: "Afecto")
        set_afecto.colors = ChartColorTemplates.pastel()
        
        let set_tristeza = BarChartDataSet(entries: entrada_tristeza, label: "Tristeza")
        set_tristeza.colors = ChartColorTemplates.colorful()
        
        let set_enojo = BarChartDataSet(entries: entrada_enojo, label: "Enojo")
        set_enojo.colors = ChartColorTemplates.joyful()
        
        let set_alegria = BarChartDataSet(entries: entrada_alegria, label: "Alegria")
        set_alegria.colors = ChartColorTemplates.vordiplom()
        
        
        let datos_emociones = BarChartData(dataSets: [set_miedo,set_afecto,set_tristeza,set_enojo,set_alegria])
        barGraficaemociones.data = datos_emociones
        
        view.addSubview(barGraficaemociones)
        //barGraficaemociones.center = view.center
        
    }
    private func general_grafica_puntaje(){
        consulta_partidas_puntaje()
        calculo_partidas_puntaje()
        //Creacion de grafica de barras
        let barGrafica_semaforo = BarChartView(frame: CGRect(x: 0,
                                                    y: 520,
                                                    width: view.frame.size.width,
                                                         height: 320))
        
        //Configuracion ejes
        //let xAxis = barGrafica.xAxis
        //let yAxis = barGrafica.rightAxis
        
        //Configuracion legend
        
        //Supply data
        var entrada_puntajenegativa = [BarChartDataEntry]()
        entrada_puntajenegativa.append(BarChartDataEntry(
            x: Double(1),
            y: Double( self.partidas_puntaje["Negativo"]! )))

        var entrada_puntajecero = [BarChartDataEntry]()
        entrada_puntajecero.append(BarChartDataEntry(
            x: Double(2),
            y: Double( self.partidas_puntaje["Cero"]! )))

        var entrada_puntajepostiva = [BarChartDataEntry]()
        entrada_puntajepostiva.append(BarChartDataEntry(
            x: Double(3),
            y: Double( self.partidas_puntaje["Positivo"]! )))
        
        let set_puntajenegativo = BarChartDataSet(entries: entrada_puntajenegativa, label: "Negativo")
        set_puntajenegativo.colors = ChartColorTemplates.material()
        
        let set_puntajecero = BarChartDataSet(entries: entrada_puntajecero, label: "Cero")
        set_puntajecero.colors = ChartColorTemplates.pastel()
        
        let set_puntajepositivo = BarChartDataSet(entries: entrada_puntajepostiva, label: "Positivo")
        set_puntajepositivo.colors = ChartColorTemplates.liberty()
        
        let datos_puntaje = BarChartData(dataSets: [set_puntajenegativo,set_puntajecero,set_puntajepositivo ])
        barGrafica_semaforo.data = datos_puntaje
        view.addSubview(barGrafica_semaforo)
        
    }
    
    private func calculo_partidas_puntaje(){
        dump(partidas_emociones_cero, name: "Puntaje de 0")
        partidas_puntaje["Cero"] = partidas_emociones_cero["Miedo"]! + partidas_emociones_cero["Afecto"]! + partidas_emociones_cero["Tristeza"]! + partidas_emociones_cero["Enojo"]! + partidas_emociones_cero["Alegria"]!
      
        
        dump(partidas_emociones_negativo, name: "Puntaje netativo")
       partidas_puntaje["Negativo"] = partidas_emociones_negativo["Miedo"]! + partidas_emociones_negativo["Afecto"]! + partidas_emociones_negativo["Tristeza"]! + partidas_emociones_negativo["Enojo"]! + partidas_emociones_negativo["Alegria"]!
        
        dump(partidas_emociones_positivo, name: "Puntaje Positivo")
        partidas_puntaje["Positivo"] = partidas_emociones_positivo["Miedo"]! + partidas_emociones_positivo["Afecto"]! + partidas_emociones_positivo["Tristeza"]! + partidas_emociones_positivo["Enojo"]! + partidas_emociones_positivo["Alegria"]!
       
        dump(partidas_puntaje,name: "Datos de la tabla")
    }
    
    
    
}
