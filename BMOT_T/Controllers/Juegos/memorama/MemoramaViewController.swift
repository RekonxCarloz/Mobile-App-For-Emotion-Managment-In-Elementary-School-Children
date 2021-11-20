//
//  MemoramaViewController.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 12/11/21.
//

import UIKit
import Firebase

class MemoramaViewController: UIViewController {

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var timer: Timer?
    
    ///Referencia para la base de datos.
    private var dabatabase = Database.database().reference()
    var nombrePerfil: String?
    ///Variables para almacenamiento de la base de datos.
    private var emocionselc: Int = 0
    private var fecha: String = ""
    private var duracion_partida : String = ""
    private let name_juego = "Memorama"
    private var dateText = ""
    private var name_emotion: String?
    
    private lazy var memoryGame = MemoryGame(numberOfCardPairs: (cardButtons.count + 1) / 2)
    var randomThemeIndex = 1
    
    @IBAction private func flipCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            memoryGame.chooseCard(at: cardNumber)
            updateViewFromModel()
            updateScoreLabel()
        }
    }
    
    private var elapsedSeconds: Int = 0 {
        didSet {
            timerLabel.text = elapsedSeconds.formattedTime()
        }
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(memoryGame.score)"
    }
    
    override func viewDidLoad() {
        newGame()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            self.elapsedSeconds += 1
        })
    }
    
    @IBAction private func newGame() {
        obtener_fecha()
        self.duracion_partida =  elapsedSeconds.formattedTime()
        self.emotion_name(selecion: randomThemeIndex)
        self.save_game(nombre_emocion: name_emotion!, fecha_partida: dateText, duracion_partida: duracion_partida, score: memoryGame.score)
        memoryGame.newGame()
        updateViewFromModel()
        emoji = [Card:String]()
        if let theme = emojiThemes[randomThemeIndex] {
            currentEmojiTheme = theme
        } else {
            currentEmojiTheme = [String]()
        }
        updateScoreLabel()
        elapsedSeconds = 0
        startTimer()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = memoryGame.cards[index]
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 1, green: 0.5768225789, blue: 0, alpha: 0) : #colorLiteral(red: 0.9475790858, green: 0.7731348276, blue: 0.8264791369, alpha: 1)
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    private var emojiThemes =
        [1: ["Miedo", "Pavor", "Espanto", "Desprotección", "Pánico", "😫", "Temor", "😣", "😧", "😥", "😰", "😨"],
         2: ["Alegría", "Encanto", "Admiración", "Paz", "Felicidad", "Motivación", "😋", "😌", "☺️", "😂", "😁", "😃"],
         3: ["Tristeza", "Soledad", "Timidez", "Abandono", "Decepción", "Melancolía", "😢", "😭", "😔", "🥺", "☹️", "😞"],
         4: ["Injusticia", "Enojo", "Rabia", "Molestia", "Enfado", "Disgusto", "😖", "😡", "😤", "😠", "😓", "😑"],
         5: ["Afecto", "Apoyo", "Amor", "Comprensión", "Ternura", "Solidaridad", "🫂", "🤗", "😚", "😊", "💙", "🥰"]]
    
    private var currentEmojiTheme = [String]()
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, currentEmojiTheme.count > 0 {
            emoji[card] = currentEmojiTheme.remove(at: currentEmojiTheme.count.arc4random)
        }
        if let selectedEmoji = emoji[card] {
            return selectedEmoji
        }
        return "?"
    }
    
    //Funcion para saber el nombre de la emocion que se esta jugando
    private func emotion_name(selecion:Int){
        switch selecion {
        case 1:
            name_emotion = "Miedo"
        case 2:
            name_emotion = "Afecto"
        case 3:
            name_emotion = "Triztesa"
        case 4:
            name_emotion = "Enojo"
        case 5:
            name_emotion = "Afecto"
        default:
            name_emotion = "Ninguna"
        }
        print(name_emotion ?? "")
        
    }
    
    
    //Funcion para la obtener la fecha de la partida
    private func obtener_fecha(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY.HH:mm"
        self.dateText = dateFormatter.string(from: date)
        
    }
    
    
    //Funcion que almacena los datos de la partida.
    private func save_game (nombre_emocion:String, fecha_partida: String, duracion_partida : String, score : Int){
        if let userEmail = Auth.auth().currentUser?.email?.safeDatabaseKey(){
            if let safeProfileName = nombrePerfil {
                dabatabase.child(userEmail).child("perfiles").child(safeProfileName).child("juegos").child(name_juego).child("emociones").child(nombre_emocion).child("partidas").childByAutoId().setValue(["fecha_partida" : fecha_partida, "duracion" : duracion_partida, "puntaje" : score ]){ error, _ in
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
}
