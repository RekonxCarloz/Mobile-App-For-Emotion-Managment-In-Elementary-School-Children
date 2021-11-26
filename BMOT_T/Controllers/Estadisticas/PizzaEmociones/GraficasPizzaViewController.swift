//
//  GraficasPizzaViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 25/11/21.
//

import UIKit
import Firebase
import Charts

class GraficasPizzaViewController: UIViewController {
    //Varaibles para necesarias para realizar la consulta
    var nombrePerfil:String?
    var ref_database = Database.database().reference()
    let name_juego = "Pizza_Emociones"
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Funcion para el boton
    */
    @IBAction func mostraremocionesAction(_ sender: UIButton) {
        
    }
    

}
