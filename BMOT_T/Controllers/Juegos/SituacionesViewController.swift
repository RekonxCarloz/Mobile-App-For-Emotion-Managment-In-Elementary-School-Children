//
//  SituacionesViewController.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 05/12/21.
//

import AVKit
import AVFoundation
import Firebase
import UIKit

class SituacionesViewController: UIViewController {
    var nombrePerfil:String?
    var situacion: Int = 1
    
    var player_item = AVPlayer()
    var player_layer = AVPlayerLayer()
    
    var player_repeat = AVQueuePlayer()
    var playerLooper : AVPlayerLooper?
    var player_itemR : AVPlayerItem?


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let randomInt = Int.random(in: 1..<5)
        situacion = randomInt
        print("Numero ramdom: \(randomInt)")
        print("Numero situacion: \(randomInt)")
        player_item = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: String(situacion), ofType: "mp4")!))
        player_layer = AVPlayerLayer(player: player_item)
        player_layer.frame = view.bounds
        player_layer.videoGravity = .resizeAspect
        view.layer.addSublayer(player_layer)
        player_item.play()
        
    }
    
    /*
    // MARK: - Metodo para la función de cada botón
    */
    //Funcion para mostrar otro video al azar
    @IBAction func otroVideoAction(_ sender: UIButton) {
        var randomInt = Int.random(in: 1..<5)
        print("Numero ramdom otro video: \(randomInt)")
        print("Numero situacion otro video: \(randomInt)")
        while situacion == randomInt {
            randomInt = Int.random(in: 1..<5)
        }
        situacion = randomInt
        //situacion = randomInt
        player_item = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: String(situacion), ofType: "mp4")!))
        player_layer = AVPlayerLayer(player: player_item)
        player_layer.frame = view.bounds
        player_layer.videoGravity = .resizeAspect
        view.layer.addSublayer(player_layer)
        player_item.play()

    }
    
    
    //Funcion para repetir video
    @IBAction func repetirAction(_ sender: UIButton) {
        player_layer = AVPlayerLayer(player: player_repeat)
        player_itemR = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: String(situacion), ofType: "mp4")!))
        self.playerLooper = AVPlayerLooper(player: player_repeat, templateItem: player_itemR!)
        player_layer.frame = view.bounds
        player_layer.videoGravity = .resizeAspect
        view.layer.addSublayer(player_layer)
        player_repeat.play()
               NotificationCenter.default.addObserver(self,
                                                      selector: #selector(playerItemDidReachEnd),
                                                                name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                                object: nil) // Add observer
    
        
    }
    
    // Notification Handling
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        player_repeat.seek(to: CMTime.zero)
        //player_repeat.play()
        player_repeat.pause()
    }
    // Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func PasarAljuegoAction(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.gamesSegues.emotionPizza, sender: self)
    }
    
    /*
    // MARK: - Metodo para la función de enviar los datos a otra vista.
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.gamesSegues.emotionPizza{
            let vc = segue.destination as! PizzaGameViewController
            vc.nombrePerfil = nombrePerfil
        }
    }

}
