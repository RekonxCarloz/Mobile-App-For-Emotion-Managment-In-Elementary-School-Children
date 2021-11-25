//
//  MenuJuegosViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 24/11/21.
//

import UIKit

class MenuJuegosViewController: UIViewController {
    var nombrePerfil:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(nombrePerfil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SopaLetrasAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.estadisticasSegues.juegoSopaLetras, sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.Segues.estadisticasSegues.juegoSopaLetras{
            let destinoVC = segue.destination as! GraficasSopaLetrasViewController
            destinoVC.nombrePerfil = nombrePerfil
        }
        
    }

}
