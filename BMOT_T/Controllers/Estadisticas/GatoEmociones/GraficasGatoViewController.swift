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
    let name_juego = "Gato_Emociones"
    
    var partidas_emociones = [
        "Miedo"     :   1,
        "Afecto"    :   2,
        "Tristeza"  :   3,
        "Enojo"     :   4,
        "Alegria"   :   5
    
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)

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
