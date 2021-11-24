//
//  RunningTimeRepository.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 22/11/21.
//

import Foundation

class RunningTimeRepository {
    
    static let instance = RunningTimeRepository()
    
    var timeGraphCollection: [TimeGraphData]?
    
    func retrieveTimeGraphCollection (completion: @escaping ([TimeGraphData]?) -> ()) {
        
        if timeGraphCollection != nil {
            completion(timeGraphCollection)
        } else {
            timeGraphCollection = self.createTimeCollection()
            completion(timeGraphCollection)
        }
    }
    
    private func createTimeCollection () -> [TimeGraphData] {
        
        let Miedo = TimeGraphData.init(order: 0, amount: "15h 30'", month: "Miedo", percentage: 76.0)
        let Afecto = TimeGraphData.init(order: 1, amount: "10h", month: "Afecto", percentage: 50.0)
        let Triztesa = TimeGraphData.init(order: 2, amount: "5h 45'", month: "Triztesa", percentage: 25.6)
        let Enojo = TimeGraphData.init(order: 3, amount: "15h 25'", month: "Enojo", percentage: 75.7)
        let Alegria = TimeGraphData.init(order: 3, amount: "10h 50'", month: "Alegría", percentage: 51.0)
        
        return [Miedo,Afecto,Triztesa,Enojo,Alegria]
    }
}
