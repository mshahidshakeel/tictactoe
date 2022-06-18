//
//  BlockView.swift
//  TicTacToe
//
//  Created by devx on 05/06/2022.
//

import UIKit

enum XO: String {
    case x = "X"
    case o = "O"
    case none = " "
}

@IBDesignable
class BlockView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 32)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        return label
    }()
    
    var onTap: (() -> Void)?
    var placement: XO = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = ""
        
        addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTap))
        )
    }
    
    func set(xo: XO) {
        titleLabel.text = xo.rawValue
        placement = xo
    }
    
    func isEmpty() -> Bool {
        return placement == XO.none
    }
    
    func isNotEmpty() -> Bool {
        return !isEmpty()
    }
    
    @objc
    private func didTap() {
        onTap?()
    }
}
