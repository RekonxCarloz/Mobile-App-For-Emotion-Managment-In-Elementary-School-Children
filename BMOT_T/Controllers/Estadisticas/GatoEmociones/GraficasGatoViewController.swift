//
//  GraficasGatoViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 25/11/21.
//

import UIKit
import Charts
import Firebase


class GraficasGatoViewController: UIViewController {
    //Varaibles para necesarias para realizar la consulta
    var nombrePerfil:String?
    var ref_database = Database.database().reference()
    let nombre_juego = "Gato_Emociones"
    
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
        consulta()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Funciones para los botones
    */
    
    @IBAction func mostraremocionesAction(_ sender: UIButton) {
        creaciongrafica()
    }
    
    /*
    // MARK: - Funcione de la consulta
    */
    private func consulta(){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfilename = nombrePerfil{
                ///Emocion: Miedo
                let consulta_miedo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(nombre_juego).child("partidas").queryOrdered(byChild: "jugador_1").queryEqual(toValue: "Miedo")
                var cont_miedo = 0
                consulta_miedo.observe(.childAdded) { (snapshot) in
                    cont_miedo  += 1
                    self.partidas_emociones["Miedo"] = cont_miedo
                }
                ///Emocion: Afecto
                let consulta_afecto = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(nombre_juego).child("partidas").queryOrdered(byChild: "jugador_1").queryEqual(toValue: "Afecto")
                var cont_afecto = 0
                consulta_afecto.observe(.childAdded) { (snapshot) in
                    cont_afecto  += 1
                    self.partidas_emociones["Afecto"] = cont_afecto
                }
                ///Emocion: Tristeza
                let consulta_tristeza = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(nombre_juego).child("partidas").queryOrdered(byChild: "jugador_1").queryEqual(toValue: "Tristeza")
                var cont_tristeza = 0
                consulta_tristeza.observe(.childAdded) { (snapshot) in
                    cont_tristeza  += 1
                    self.partidas_emociones["Tristeza"] = cont_tristeza
                }
                ///Emocion: Enojo
                let consulta_enojo = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(nombre_juego).child("partidas").queryOrdered(byChild: "jugador_1").queryEqual(toValue: "Enojo")
                var cont_enojo = 0
                consulta_enojo.observe(.childAdded) { (snapshot) in
                    cont_enojo  += 1
                    self.partidas_emociones["Enojo"] = cont_enojo
                }
                ///Emocion: Alegria
                let consulta_alegria = ref_database.child(userEmail).child("perfiles").child(safeProfilename).child("juegos").child(nombre_juego).child("partidas").queryOrdered(byChild: "jugador_1").queryEqual(toValue: "Alegre")
                var cont_alegria = 0
                consulta_alegria.observe(.childAdded) { (snapshot) in
                    cont_alegria  += 1
                    self.partidas_emociones["Alegria"] = cont_alegria
                }
                
            }
        }
        
    }
    
    
    /*
    // MARK: - Funcione de la creacion de grafica
    */
    
    private func creaciongrafica(){
        //Creacion de grafica de barras emociones
        let barGraficaemociones = BarChartView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.size.width,
                                                             height: view.frame.width))
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
        barGraficaemociones.center = view.center
    }
    
}
