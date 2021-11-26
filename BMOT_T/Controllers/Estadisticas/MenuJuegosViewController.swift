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
    
    @IBAction func MemoriaAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.estadisticasSegues.juegoMemoramaEmociones, sender: self)
    }
    
    @IBAction func GatoAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.estadisticasSegues.juegoGatoEmociones, sender: self)
    }
    @IBAction func PizzaAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.estadisticasSegues.juegoPizzaEmociones, sender: self)
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
        
        if segue.identifier == K.Segues.estadisticasSegues.juegoMemoramaEmociones{
            let destinoVC = segue.destination as! GraficasMemoramaViewController
            destinoVC.nombrePerfil = nombrePerfil
        }
        
        if segue.identifier == K.Segues.estadisticasSegues.juegoGatoEmociones{
            let destinoVC = segue.destination as! GraficasGatoViewController
            destinoVC.nombrePerfil = nombrePerfil
        }
        
        if segue.identifier == K.Segues.estadisticasSegues.juegoPizzaEmociones{
            let destinoVC = segue.destination as! GraficasPizzaViewController
            destinoVC.nombrePerfil = nombrePerfil
        }
        
        
        
    }

}
