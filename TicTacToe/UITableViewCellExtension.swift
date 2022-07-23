//
//  UITableViewCellExtension.swift
//  TicTacToe
//
//  Created by devx on 18/06/2022.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}
