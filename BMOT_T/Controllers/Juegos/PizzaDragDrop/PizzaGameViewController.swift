//
//  PizzaGameViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 16/11/21.
//

import UIKit
import Firebase

class PizzaGameViewController: UIViewController {
    
    var nombrePerfil:String?
    ///Referencia para la base de datos.
    private var dabatabase = Database.database().reference()
    //Nombre del juego:
    private let name_juego = "Pizza_Emociones"

    //Variables para la base de datos.
    private var fecha: String = ""
    //private var duracion_partida : String = ""
    private var dateText = ""
    private var tiempo_partida : String = ""
    
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
    
    private var elapsedSeconds: Int = 0 {
        didSet {
            tiempo_partida = elapsedSeconds.formattedTime()
            //dump(tiempo_partida)
        }
    }
    
    //Version 2 del timer:
    private var timer_2: Timer?
    private var isPaused: Bool = false {
        didSet {
            if isPaused == true {
                timer_2?.invalidate()
            }
        }
    }
    
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
    
    /// Start and display clock time.
    private func startTimer() {
        timer_2?.invalidate()
        timer_2 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.elapsedSeconds += 1
            print("Timer:\(self.elapsedSeconds)")
        })
    }
    
    //MARK: Metodos de los botones
    // Metodo del boton de inicar.
    @IBAction func IniciarActionButton(_ sender: UIButton) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer_action), userInfo: nil, repeats: true)
        
        //Version de timer 2.
        startTimer()
        
        self.collectionview1.dragInteractionEnabled = true
        obtener_fecha()
    }
    
    @IBAction func PararActionButton(_ sender: UIButton) {
        self.collectionview1.dragInteractionEnabled = false
        timer.invalidate()
        
        if isPaused {
            isPaused = false
            print("Tiempo de la partida:\(elapsedSeconds)")
        } else {
            isPaused = true
            print("Tiempo de la partida:\(elapsedSeconds)")
        }
        
        
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
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Afecto, Tristeza y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Afecto y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Afecto y Tristeza", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Afecto, Enojo y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Afecto y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Afecto y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor == cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 1 ,Tristeza = 0 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo y Afecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Tristeza, Enojo y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Tristeza y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Tristeza y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 1 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo y Tristeza", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo, Enojo y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 0 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if(emocion == "Miedo" && valor > 0 && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!){
                //Miedo = 1, Afecto = 0 ,Tristeza = 0 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Miedo y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Afecto, Tristeza, Enojo y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Afecto, Tristeza y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Afecto, Tristeza y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor == cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 1 ,Enojo = 0 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Afecto y Tristeza", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Afecto, Enojo y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 0 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Afecto y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 1 ,Tristeza = 0 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Alegria y Afecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]! ) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Tristeza, Alegria y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)

            }
            
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor == cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]! ) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 1 ,Enojo = 1 , Alegria = 0
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Tristeza  y Enojo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Enojo"]! && valor == cont_emociones["Alegria"]! ) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 1 ,Enojo = 0 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Tristeza  y Alegria", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        
            
            if (emocion == "Enojo"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor == cont_emociones["Alegria"]!) {
                
                //Miedo = 0, Afecto = 0 ,Tristeza = 0 ,Enojo = 1 , Alegria = 1
                let alert = UIAlertController(title: "", message: "Las emociones que sobre salen son Enojo y Alegria", preferredStyle: .alert)
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
                let alert = UIAlertController(title: "", message: "Se muestra que el Miedo es mayor :s", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            if (emocion == "Afecto"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondoImage.backgroundColor = UIColor.init(red: 0, green: 255, blue: 77, alpha: 0.9)
                let alert = UIAlertController(title: "", message: "Se muestra que el Afecto es mayor :3", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if (emocion == "Tristeza"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Enojo"]! && valor > cont_emociones["Alegria"]! ) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                self.fondoImage.backgroundColor = UIColor.init(red: 91, green: 0, blue: 255, alpha: 1)
                
                let alert = UIAlertController(title: "", message: "Se muestra que la Tristeza es mayor :(", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if (emocion == "Enojo"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Alegria"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
                
                self.fondoImage.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 1)
                
                let alert = UIAlertController(title: "", message: "Se muestra que el Enojo es mayor >:|", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            if (emocion == "Alegria"  && valor > 0 && valor > cont_emociones["Miedo"]! && valor > cont_emociones["Afecto"]! && valor > cont_emociones["Tristeza"]! && valor > cont_emociones["Enojo"]!) {
                
                //Cambio de color:
                print("Cambio de color a: \(emocion_color[emocion]!)")
               
                self.fondoImage.backgroundColor = UIColor.init(red: 255, green: 255, blue: 0, alpha: 1)
                
                let alert = UIAlertController(title: "", message: "Se muestra que la Alegria es mayor =D", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        
        
        }
        dump(cont_emociones) //-> es el diccionario de las emociones para el conteo de las rebanadas.
        //        Hacer llamar los valores que se van a ocupar para encontrar el almacenamiento de los datos
        //        de la partidas
        self.tiempo_partida  = elapsedSeconds.formattedTime()

        self.guardar_partida(name_juego: self.name_juego, fecha_partida: self.dateText, duracion_partida: tiempo_partida,
                             miedo: cont_emociones["Miedo"]!,
                             afecto: cont_emociones["Afecto"]!,
                             tristeza: cont_emociones["Tristeza"]!,
                             enojo: cont_emociones["Enojo"]!,
                             alegria: cont_emociones["Alegria"]!)
        
        
    }
    
    //Funcion que almacena los datos de la partida.
    private func guardar_partida(name_juego : String,fecha_partida: String, duracion_partida : String, miedo : Int, afecto : Int, tristeza : Int, enojo : Int, alegria : Int){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfileName = nombrePerfil {
                dabatabase.child(userEmail).child("perfiles").child(safeProfileName).child("juegos").child(name_juego).child("partidas").childByAutoId().setValue(["fecha_partida" : fecha_partida, "duracion" : duracion_partida, "Miedo" : miedo, "Afecto" : afecto, "Tristeza" : tristeza, "Enojo" : enojo , "Alegria" : alegria]){ error, _ in
                        if error == nil{
                            print("Se guardo exitosa la partida")
                        }
                        else{
                            print("El error es: \(error!)")
                       
                            }
                    }
            }
        }
        
    }
    
    
    //Funcion para la obtener la fecha de la partida
    private func obtener_fecha(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        self.dateText = dateFormatter.string(from: date)
        
    }
  
    
    
    @IBAction func ReiniciarActionButton(_ sender: UIButton) {
        //print("Se reincio el juego")
        self.pressbtn = true
        if (self.pressbtn == true){
            self.items2 = [String]()
            self.cont = 0
            self.elapsedSeconds = 0
            self.fondoImage.backgroundColor = nil
            self.collectionview2.reloadData()
            self.obtener_fecha()
            
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
