//
//  SwitchCell.swift
//  TicTacToe
//
//  Created by devx on 18/06/2022.
//

import UIKit

class SwitchCell: UITableViewCell {
    @IBOutlet private weak var uiLabel: UILabel! {
        didSet {
            
        }
    }
    
    @IBOutlet private weak var uiSwitch: UISwitch! {
        didSet {
            uiSwitch.addTarget(self, action: #selector(onSwitched(_:)), for: .valueChanged)
        }
    }
    
    private var onSwitch: ((Bool) -> Void)?

    func configure(title: String, isOn: Bool, onSwitch: @escaping (Bool) -> Void) {
        self.uiLabel.text = title
        self.uiSwitch.isOn = isOn
        self.onSwitch = onSwitch
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    @objc private func onSwitched(_ sender: UISwitch) {
        onSwitch?(sender.isOn)
    }
}
