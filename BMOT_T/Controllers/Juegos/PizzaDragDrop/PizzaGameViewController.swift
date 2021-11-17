//
//  PizzaGameViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 16/11/21.
//

import UIKit

class PizzaGameViewController: UIViewController {
    
    //MARK: Variables privadas de uso
    private let emocion_color = [
        "Miedo":"Verde oscuro",
        "Afecto":"Verde claro",
        "Tristeza":"Azul oscuro",
        "Enojo":"Rojo",
        "Alegria":"Amarillo"]
    
    private var dictyonary_items = [
        "reb_felicidad": "Alegria",
        "reb_afecto":"Afecto",
        "reb_agradecimiento":"Afecto",
        "reb_furia":"Enojo",
        "reb_disgusto":"Enojo",
        "reb_contento":"Alegria",
        "reb_encanto":"Alegria",
        "reb_soledad":"Tristeza",
        "reb_tristeza":"Tristeza",
        "reb_desconsuelo":"Tristeza",
        "reb_duda":"Miedo",
        "reb_enfado":"Enojo",
        "reb_timidez":"Miedo",
        "reb_temor":"Miedo"]
    
    private var dictionario_imagens = [
        "reb_felicidad": "felicidad",
        "reb_afecto":"afecto",
        "reb_agradecimiento":"agradecimiento",
        "reb_furia":"furia",
        "reb_disgusto":"disgusto",
        "reb_contento":"contento",
        "reb_encanto":"encanto",
        "reb_soledad":"soledad",
        "reb_tristeza":"tristeza",
        "reb_desconsuelo":"desconsuelo",
        "reb_duda":"duda",
        "reb_enfado":"enfado",
        "reb_timidez":"timidez",
        "reb_temor":"temor"]
    
    //Data Source for CollectionView-1
    private var items1 = [String]()
    private var items1_name = [String]()
    
    //Data Source for CollectionView-2
    private var items2 = [String]()
    private var items2_name = [String]()
    
    //Variables
    private var cont: Int = 0
    private var timer = Timer()
    private var pressbtn = false
    
    //MARK: Outlets
    @IBOutlet weak var collectionview1: UICollectionView!
    
    @IBOutlet weak var collectionview2: UICollectionView!
    
    @IBOutlet weak var fondoImage: UIImageView!
    

    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //items1 configuracion de listado
        self.items1 = Array(dictionario_imagens.keys)
        self.items1_name = Array(dictionario_imagens.values)
        
        //CollectionView1 configuracion de Drag and Drop
        self.collectionview1.dragInteractionEnabled = false
        self.collectionview1.dragDelegate = self
        self.collectionview1.dropDelegate = self
        
        //CollectionView2 configuracion de Drag and Drop
        self.collectionview2.dragInteractionEnabled = true
        self.collectionview2.dragDelegate = self
        self.collectionview2.dropDelegate = self
        self.collectionview2.reorderingCadence = .fast

     
    }
    
    //MARK: Definiciones de funciones.
    /// Metodo para el timer
    @objc private func timer_action(){
        cont += 1
        print("Timer:\(cont)")
        
    }
    
    //MARK: Metodos de los botones
    // Metodo del boton de inicar.
    @IBAction func IniciarActionButton(_ sender: UIButton) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer_action), userInfo: nil, repeats: true)
        self.collectionview1.dragInteractionEnabled = true
    }
    
    @IBAction func PararActionButton(_ sender: UIButton) {
        self.collectionview1.dragInteractionEnabled = false
        timer.invalidate()
        
        //Declaracion de variables
        var cont_emociones = [
                    "Miedo":0,
                    "Afecto":0,
                    "Tristeza":0,
                    "Enojo":0,
                    "Alegria":0]
        for code in items2{
            if let mensaje = dictyonary_items[code]{
                cont_emociones[mensaje]! += 1
                
            }else {
                print("No hay rebanadas")
            }
        }
        // For que permite recorrer el diccionario del conteo de palabras relacionadas con las emociones MATEA con el fin de mostar cual o cuales son las emociones que predominan más representandola de alguna manera (Cambio de color del fondo de la mesa o mostrando una alerta)
        for (emocion,valor) in cont_emociones{
            print("Contenido cont_emociones: \(emocion):\(valor)")
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = V, Afecto = V ,Tristeza = V ,Enojo = V , Alegria = V
                let alert = UIAlertController(title: "", message: "En la mesa se encuentran todas las emociones!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, afecto, tristeza y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, afecto y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, afecto y tristeza", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, afecto, enojo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, afecto y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, afecto y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo y afecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, tristeza, enojo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, tristeza y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, tristeza y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo y tristeza", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo, enojo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 0 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 0 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son miedo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  afecto, tristeza, enojo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  afecto, tristeza y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  afecto, tristeza y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  afecto y tristeza", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  afecto, enojo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  afecto y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 0 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son  alegria y afecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]! ) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son tristeza, alegria y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)

            }
            
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]! ) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son tristeza  y enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]! ) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son tristeza  y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        
            
            if (emocion == "Enojo"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son enojo y alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if (emocion == "Enojo"  && valor == 0 && valor == cont_emociones["Miedo"]! && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 0 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "No hay rebanadas en la mesa", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            
            if(emocion == "Miedo"  && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondoImage.backgroundColor = UIColor.init(red: 0, green: 123, blue: 0, alpha: 1)
                let alert = UIAlertController(title: "", message: "Se muestra que el miedo es mayor :s", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondoImage.backgroundColor = UIColor.init(red: 0, green: 255, blue: 77, alpha: 0.9)
                let alert = UIAlertController(title: "", message: "Se muestra que el afecto es mayor :3", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]! ) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                self.fondoImage.backgroundColor = UIColor.init(red: 91, green: 0, blue: 255, alpha: 1)
                
                let alert = UIAlertController(title: "", message: "Se muestra que la tristeza es mayor :(", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if (emocion == "Enojo"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Alegria"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondoImage.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 1)
                
                let alert = UIAlertController(title: "", message: "Se muestra que el enojo es mayor >:|", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if (emocion == "Alegria"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
               
                self.fondoImage.backgroundColor = UIColor.init(red: 255, green: 255, blue: 0, alpha: 1)
                
                let alert = UIAlertController(title: "", message: "Se muestra que la alegria es mayor =D", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        
        
        }
        dump(cont_emociones)
        
    }
    
    @IBAction func ReiniciarActionButton(_ sender: UIButton) {
        //print("Se reincio el juego")
        self.pressbtn = true
        if (self.pressbtn == true){
            self.items2 = [String]()
            self.cont = 0
            self.fondoImage.backgroundColor = UIColor.white
            self.collectionview2.reloadData()
            
        }
        self.collectionview1.dragInteractionEnabled = false
    }
    
    @IBAction func InfoActionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Instrucciones", message: "Primer botón: Iniciar el juego.\n Segundo botón: Para la partida y muestra informacion debido a las rebanas seleccionadas. \n Tercer botón: Reinicia el juego.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: Metodos de funcionamiento
    
    /// This method moves a cell from source indexPath to destination indexPath within the same collection view. It works for only 1 item. If multiple items selected, no reordering happens.
    ///
    /// - Parameters:
    ///   - coordenadas: coordinator obtained from performDropWith: UICollectionViewDropDelegate method
    ///   - destinoIndexPath: indexpath of the collection view where the user drops the element
    ///   - collectionView: collectionView in which reordering needs to be done.
    private func reorderItems(coordinator:UICollectionViewDropCoordinator, destinationIndexPath:IndexPath, collectionView:UICollectionView)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath
        {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0)
            {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                if collectionView == self.collectionview2
                {
                    self.items2.remove(at: sourceIndexPath.row)
                    self.items2.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                    
                }
                else
                {
                    self.items1.remove(at: sourceIndexPath.row)
                    self.items1.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                }
        
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
    }
    
    /// This method copies a cell from source indexPath in 1st collection view to destination indexPath in 2nd collection view. It works for multiple items.
    ///
    /// - Parameters:
    ///   - coordinator: coordinator obtained from performDropWith: UICollectionViewDropDelegate method
    ///   - destinationIndexPath: indexpath of the collection view where the user drops the element
    ///   - collectionView: collectionView in which reordering needs to be done.
    private func copyItems(coordinator:UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView)
    {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            for (index, item) in coordinator.items.enumerated()
            {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                if collectionView == self.collectionview2
                {
                    self.items2.insert(item.dragItem.localObject as! String, at: indexPath.row)
                    
                }
                else
                {
                    self.items1.insert(item.dragItem.localObject as! String, at: indexPath.row)
                }
                indexPaths.append(indexPath)
                
            }
            collectionView.insertItems(at: indexPaths)
        })
    }
    

}

// MARK: - UICollectionViewDataSource Methods
extension PizzaGameViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionView == self.collectionview1 ? self.items1.count : self.items2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.collectionview1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PizzaGameCollectionViewCell
            cell.customimage?.image = UIImage(named: self.items1[indexPath.row])
            cell.customlabel.text = self.items1_name[indexPath.row].capitalized
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! PizzaGameCollectionViewCell
            cell.customimage?.image = UIImage(named: self.items2[indexPath.row])
           
            
            for code in items2{
                if let name  = dictionario_imagens[code]{
                    self.items2_name.append(name)
                    cell.customlabel.text = name.capitalized
                }
            }
                
            return cell
        }
        
    }
    
}
// MARK: - UICollectionViewDragDelegate Methods
extension PizzaGameViewController : UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem]
    {
        let item = collectionView == collectionview1 ? self.items1[indexPath.row] : self.items2[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem]
    {
        let item = collectionView == collectionview1 ? self.items1[indexPath.row] : self.items2[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters?
    {
        if collectionView == collectionview1
        {
            let previewParameters = UIDragPreviewParameters()
            previewParameters.visiblePath = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 120, height: 120))
            return previewParameters
        }
        return nil
    }
}
// MARK: - UICollectionViewDropDelegate Methods
extension PizzaGameViewController : UICollectionViewDropDelegate
{
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool
    {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        if collectionView === self.collectionview1
        {
            if collectionView.hasActiveDrag{
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        }
        else
        {
            if collectionView.hasActiveDrag
            {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            else
            {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
            
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator)
    {
        let destinationIndexPath: IndexPath
        if let indexPath  = coordinator.destinationIndexPath
        {
            destinationIndexPath = indexPath
        }
        else
        {
            // Get last index path of table view.
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        switch coordinator.proposal.operation
        {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
                    
        case .copy:
            self.copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        
        default:
            return
        }
        
    }
    
}
