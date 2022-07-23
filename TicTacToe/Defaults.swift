//
//  Defaults.swift
//  TicTacToe
//
//  Created by devx on 18/06/2022.
//

import Foundation
import UIKit

class Defaults {
    private static let DARK_MODE_KEY = "DARK_MODE_KEY"
    private static let defaults = UserDefaults.standard
    
    static var darkMode: Bool {
        get {
            defaults.bool(forKey: DARK_MODE_KEY)
        }
        set {
            defaults.set(newValue, forKey: DARK_MODE_KEY)
            updateUI(newValue)
        }
    }
    
    private static func updateUI(_ isDark: Bool) {
        
    }
}
