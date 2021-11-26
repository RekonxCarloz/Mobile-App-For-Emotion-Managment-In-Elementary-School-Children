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
    
    //Variable de las partidas de Sopa de Letras por emociones
    var partidas_emociones = [
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

    }
    

    /*
    // MARK: - Funciones para los botones
    */
    @IBAction func mostrartotalAction(_ sender: UIButton) {
        general_grafica()
        
    }
    
    
    @IBAction func mostrarrangosAction(_ sender: UIButton) {
        
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
                    //dump(self.partidas_emociones["Miedo"]!, name: "Miedo")
                    
                }
                
                //Consulta para saber cuantas partidas hay en la emocion de Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Afecto")
                    consulta_afecto.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let afecto = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Afecto"]! = afecto
                        //dump(self.partidas_emociones["Afecto"]!)
                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Tristeza")
                    consulta_tristeza.observe(DataEventType.value) { (snapshot)  in
                        
                        let dict = snapshot.value as! [String : Any]
                        let tristeza = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Tristeza"]! = tristeza
                        //dump(self.partidas_emociones["Tristeza"]!)
                        
                        
                    }
                
                //Consulta para saber cuantas partidas hay en la emocion de Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Enojo")
                    consulta_enojo.observe(DataEventType.value) { (snapshot)  in

                        let dict = snapshot.value as! [String : Any]
                        let enojo = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Enojo"]!  = enojo
                        //dump(self.partidas_emociones["Enojo"]! )
                        
                    
                        }
                
                //Consulta para saber cuantas partidas hay en la emocion de Alegria
                    let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(name_juego).child("emociones").child("Alegria")
                consulta_alegria.observe(DataEventType.value) { (snapshot)  in
                        
                    let dict = snapshot.value as! [String : Any]
                    let alegria = dict["num_partidas"] as? Int ?? 0
                        self.partidas_emociones["Alegria"]! = alegria
                        //dump(self.partidas_emociones["Alegria"]! )
                    
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
    
    
    
}
