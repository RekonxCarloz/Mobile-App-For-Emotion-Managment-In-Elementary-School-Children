//
//  TimeGraphData.swift
//  BMOT_T
//
//  Created by Jonathan Garcica on 22/11/21.
//

import Foundation

struct TimeGraphData {
    var order: Int
    var amount: String
    var month: String
    var percentage: Double
    
    init (order: Int, amount: String, month: String, percentage: Double) {
        self.order = order
        self.amount = amount
        self.month = month
        self.percentage = percentage
    }
}
