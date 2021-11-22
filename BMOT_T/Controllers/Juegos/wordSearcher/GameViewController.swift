//
//  ViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 11/11/21.
//
import Firebase
import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var overlayView: LinesOverlay!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var wordListCollectionView: WordListCollectionView!
    
    
    ///Referencia para la base de datos.
    private var dabatabase = Database.database().reference()
    var nombrePerfil: String?
    
    
    ///Datos para la base de datos.
    private var emocionselc: Int = 0 // Emocion seleccionada
    private var fecha: String = ""
    private let name_juego = "Sopa_de_Letras"
    private var dateText = ""
    private var name_jugador : String?
    private var palabrasEncontradas = 0
    private var color_Semaforo = ""
    private var name_emocion = "Ninguna"
    private var duracion = ""
    
    var emocionNum = 1
    lazy private var gradientLayer: CAGradientLayer = CAGradientLayer()
    lazy fileprivate var gridGenerator: WordGridGenerator = {
        return WordGridGenerator(words: emocionElegida(emocionNum), row: nRow, column: nCol)
    }()
    fileprivate let nRow = 10
    fileprivate let nCol = 10
    fileprivate var grid: Grid = Grid()
    
    
    
    private func emocionElegida(_ emocion: Int) -> [String]{
        
        let miedoPalabras = ["miedo", "pavor", "espanto", "temor", "panico"]
        
        let alegriaPalabras = ["ALEGRIA", "ENCANTO", "ADMIRACION", "PAZ", "FELICIDAD", "MOTIVACION"]
        
        let tristezaPalabras = ["TRISTEZA", "SOLEDAD", "TIMIDEZ", "ABANDONO", "DECEPCION", "MELANCOLIA"]
        
        let enojoPalabras = ["INJUSTICIA", "ENOJO", "RABIA", "MOLESTIA", "ENFADO", "DISGUSTO"]
        
        let afectoPalabras = ["AFECTO", "APOYO", "AMOR", "RESPETO", "TERNURA", "EMPATIA"]
        
        switch emocion {
        case 1:
            name_emocion = "Miedo"
            return miedoPalabras
        case 2:
            name_emocion = "Alegría"
            return alegriaPalabras
        case 3:
            name_emocion = "Tristeza"
            return tristezaPalabras
        case 4:
            name_emocion = "Enojo"
            return enojoPalabras
        default:
            name_emocion = "Afecto"
            return afectoPalabras
        }
    }
    
    /// Used to display elapsed time of the game.
    /// The timer can be paused and resumed.
    private var elapsedSeconds: Int = 0 {
        didSet {
            timerLabel.text = elapsedSeconds.formattedTime()
        }
    }
    private var timer: Timer?
    private var isPaused: Bool = false {
        didSet {
            if isPaused {
                timer?.invalidate()
            } else {
                startTimer()
            }
        }
    }
    
    /// We compute letter cell size. We then notify this to the overlay
    /// to draw the lines.
    /// This should be updated properly in case orientation changes.
    private var cellSize: CGSize {
        let w = gridCollectionView.bounds.width / 13
        let h = gridCollectionView.bounds.height / 11.7
        return CGSize(width: w, height: h)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Because there's no layout constraint for a CALayer.
        gradientLayer.frame = gridCollectionView.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emocionselc = emocionNum
        setupWordListCollectionView()
        setupGridCollectionView()
        setupOverlayView()
        loadGame()
        wordListCollectionView.isHidden = true
    }
    
    @IBAction func restartGame(_ sender: Any) {
        restartGame()
    }
    
    @IBAction func endGamePressed(_ sender: UIButton) {
        timer?.invalidate()
        duracion = elapsedSeconds.formattedTime()
        var tituloAlerta = ""
        var mensajeAlerta = ""
        
        switch palabrasEncontradas {
        case 0...2:
            tituloAlerta = "Sigue mejorando."
            mensajeAlerta = "Podrás hacerlo mejor para la próxima vez.\n\n \(palabrasEncontradas) de \(gridGenerator.words.count) palabras encontradas."
            color_Semaforo = "Rojo"
        case 3...5:
            tituloAlerta = "¡Casi lo logras, sigue así!."
            mensajeAlerta = "Podrás hacerlo mejor para la próxima vez.\n\n \(palabrasEncontradas) de \(gridGenerator.words.count) palabras encontradas."
            color_Semaforo = "Amarillo"
        default:
            tituloAlerta = "¡Enhorabuena!."
            mensajeAlerta = "Eres capaz de identificar bien tu \(name_emocion).\n\n \(palabrasEncontradas) de \(gridGenerator.words.count) palabras encontradas."
            color_Semaforo = "Verde"
        }
        Consulta(nombre_emocion: name_emocion, fecha_partida: dateText, duracion: duracion, palabras: palabrasEncontradas, color_Semaforo: color_Semaforo)
        let alert = UIAlertController(title: tituloAlerta, message: mensajeAlerta, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Regresar", style: .default, handler:{_ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    private func loadGame() {
        DispatchQueue.global().async {
            if let grid = self.gridGenerator.generate() {
                self.grid = grid
                DispatchQueue.main.async {
                    self.gridCollectionView.reloadData()
                    self.startTimer()
                    self.obtener_fecha()
                }
            }
        }
    }
    
    private func obtener_fecha(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY.HH:mm"
        self.dateText = dateFormatter.string(from: date)
        
    }
    
    private func setupWordListCollectionView() {
        wordListCollectionView.words = gridGenerator.words
    }
    
    private func setupGridCollectionView() {
        // Setup pan gesture
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panHandling(gestureRecognizer:)))
        gridCollectionView.addGestureRecognizer(panGR)
        
        // Setup background gradient layer
        gradientLayer.frame = gridCollectionView.bounds
        // Get the background color of the headerview
        gradientLayer.colors = [headerView.backgroundColor!.cgColor, UIColor.white.cgColor]
        let bgView = UIView(frame: gridCollectionView.bounds)
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        gridCollectionView.backgroundView = bgView
        
        // Setup border for easing look
        gridCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        gridCollectionView.layer.borderWidth = 1.0
    }
    
    private func setupOverlayView() {
        overlayView.row = nRow
        overlayView.col = nCol
    }
    
    
    /// Helper function to get row and col from an indexPath.
    ///
    /// - Parameter index: an index from an indexPath.
    /// - Returns: row and col of the cell in the grid.
    private func position(from index: Int) -> Position {
        return Position(row: index / nRow, col: index % nCol)
    }
    
    /// Start and display clock time.
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.elapsedSeconds += 1
        })
    }
    
    fileprivate func restartGame() {
        overlayView.reset()
        wordListCollectionView.reset()
        elapsedSeconds = 0
        palabrasEncontradas = 0
        loadGame()
    }
    
    @objc func panHandling(gestureRecognizer: UIPanGestureRecognizer) {
        //Seleccion de emocion:
        let point = gestureRecognizer.location(in: gridCollectionView)
        guard let indexPath = gridCollectionView.indexPathForItem(at: point) else {
            return
        }
        let pos = position(from: indexPath.row)
        
        switch gestureRecognizer.state {
        case .began:
            overlayView.addTempLine(at: pos)
            // Select item to animate the cell
            // Since we set the collection view `selection mode` to single
            // This means only one letter is animated at a time.
            // So in `.ended` event, we just need to deselect one cell.
            gridCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        case .changed:
            if overlayView.moveTempLine(to: pos) {
                gridCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                
            }
        case .ended:
            // Stop animation
            gridCollectionView.deselectItem(at: indexPath, animated: true)
            guard let startPos = overlayView.tempLine?.startPos else {
                return
            }
            // Get the word from the pre-computed map
            let key = WordGridGenerator.wordKey(for: startPos, and: pos)
            if let word = gridGenerator.wordsMap[key] {
                overlayView.acceptLastLine()
                wordListCollectionView.select(word: word)
                palabrasEncontradas += 1
                print("Palabras encontradas: \(palabrasEncontradas)")
                if overlayView.permanentLines.count == gridGenerator.words.count {
                    let alert = UIAlertController(title: "¡¡FELICIDADES!!", message: "Distingues al 100% tu \(name_emocion). \n\n Haz encontrado \(palabrasEncontradas) de \(gridGenerator.words.count) palabras.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Regresar", style: .default, handler:{_ in
                        self.navigationController?.popToRootViewController(animated: true)
                    }))
                    self.present(alert, animated: true)
                    // Pause the time because user has won the game.
                    timer?.invalidate()
                    /// Finalizacion del juego:
                    dump(gridGenerator.words)
                    dump(gridGenerator.words.count)
                    color_Semaforo = "Verde"
                    duracion = elapsedSeconds.formattedTime()
                    self.Consulta(nombre_emocion: name_emocion,fecha_partida: dateText, duracion: duracion, palabras: overlayView.permanentLines.count, color_Semaforo: color_Semaforo)
                }
            }
            // Remove the temp line
            overlayView.removeTempLine()
        default: break
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (_) in
            // Force re-draw the collection views when orientation changes.
            self.gridCollectionView.collectionViewLayout.invalidateLayout()
            self.wordListCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    //Funcion Para enviar datos a la base de datos.
    /// Para esta funcion se tiene que reacudar los valores que se agregaran a la base de datos:
    /// Datos:
    /// - Fecha de la partida.
    /// - La emción que se selecciono.
    /// - Tiempo que duro en la partida.
    /// - "Las palabras que puedo encontrar."
    ///
    private func Consulta(nombre_emocion:String, fecha_partida: String, duracion : String, palabras: Int, color_Semaforo:String){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfileName = nombrePerfil {
                dabatabase.child(userEmail).child("perfiles").child(safeProfileName).child("juegos").child(name_juego).child("emociones").child(nombre_emocion).child("partidas").childByAutoId().setValue(["fecha_partida" : fecha_partida, "duracion" : duracion, "Palabras_encontradas": palabras, "Color_Semaforo" : color_Semaforo]){ error, _ in
                    if error == nil{
                        print("Se guardo exitosa la partida")
                    }else{
                        print("El error es: \(error!)")
                        
                    }
                }
            }
        }
    }
    
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid.count * (grid.first?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.cellId, for: indexPath) as! GridCollectionViewCell
        let pos = position(from: indexPath.row)
        cell.label.text = String(grid[pos.row][pos.col])
        return cell
    }
}
