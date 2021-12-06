//
//  Constants.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import Foundation
import UIKit


struct K{
    static let appName = "🤖 BMOT 🤖"
    static let cellIdentifier = "profileCell"
    static let cellNibName = "ProfileCollectionViewCell"
    
    struct Segues{
        static let registerToChooseProfile = "RegisterToChooseProfile"
        static let loginToChooseProfile = "LoginToChooseProfile"
        static let chooseProfileToHome = "chooseProfileToHome"
        static let createProfileToHome = "createProfileToHome"
        static let wordSearcherGameToEmotions = "wordSearcherToEmotions"
        static let memoramaGameToEmotions = "memoramaToEmotions"
        static let ticTacToeGameToEmotions = "ticTacToeToEmotions"
        //static let pizzaGameSegue = "pizzaGameSegue"
        static let situacionesPizzaGame = "SituacionespizzaGameSegue"
        
        static let stadictToMenuJuegos = "menuJuegosSegue"
        struct estadisticasSegues{
            static let juegoSopaLetras = "estadisticaSLSegue"
            static let juegoPizzaEmociones = "estadisticaPESegue"
            static let juegoMemoramaEmociones = "estadisticaMSegue"
            static let juegoGatoEmociones = "estadisticaGESegue"
        }
        
        struct gamesSegues{
            static let emotionWordSearcher = "emotionWordSearcherSegue"
            static let emotionMemorama = "emotionMemoramaSegue"
            static let emotionTicTacToe = "startTicTacToeSegue"
            static let emotionPizza = "pizzaGameSegue"
        }
    }
    
}
