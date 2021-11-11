//
//  extensions.swift
//  BMOT_T
//
//  Created by Carlos Cobian on 02/11/21.
//

import UIKit

extension String{
    func safeDatabaseKey() -> String{
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
    
    func color() -> UIColor? {
        switch(self){
        case "systemPink":
            return UIColor.systemPink
        case "systemRed":
            return UIColor.systemRed
        case "systemGreen":
            return UIColor.systemGreen
        case "systemOrange":
            return UIColor.systemOrange
        case "systemBlue":
            return UIColor.systemBlue
        default:
            return nil
        }
    }
}

extension Int {
    /// Get display formatted time from number of seconds
    /// E.g. 65s = 01:05
    ///
    /// - Returns: the display string
    func formattedTime() -> String {
        let seconds: Int = self % 60
        let minutes: Int = self / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
