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
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Funciones para los botones
    */
    @IBAction func mostrartotalAction(_ sender: UIButton) {
    }
    
    
    @IBAction func mostrarrangosAction(_ sender: UIButton) {
    }
    
}
