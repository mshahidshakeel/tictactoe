//
//  SettingsVC.swift
//  TicTacToe
//
//  Created by devx on 18/06/2022.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet private weak var uiTableView: UITableView! {
        didSet {
            uiTableView.dataSource = self
            uiTableView.delegate = self
        }
    }
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else {
            fatalError()
        }
        
        cell.configure(title: "Dark Mode", isOn: Defaults.darkMode) { isOn in
            Defaults.darkMode = isOn
        }
        
        return cell
    }
}
