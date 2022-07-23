//
//  ViewController.swift
//  TicTacToe
//
//  Created by devx on 05/06/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var baseView: UIView! {
        didSet {
            // baseView.layer.applySketchShadow()
            baseView.layer.shadowColor = UIColor.black.cgColor
            baseView.layer.shadowRadius = 5.0
            baseView.layer.shadowOpacity = 0.5
            baseView.layer.shadowOffset = .zero
            baseView.layer.cornerRadius = 10.0
        }
    }
    
    @IBOutlet private weak var resetBtn: UIButton! {
        didSet {
            resetBtn.isHidden = true
            resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var block00: BlockView! {
        didSet {
            block00.onTap = {
                self.tapped(x: 0, y: 0)
            }
        }
    }
    
    @IBOutlet private weak var block01: BlockView! {
        didSet {
            block01.onTap = {
                self.tapped(x: 0, y: 1)
            }
        }
    }
    
    @IBOutlet private weak var block02: BlockView! {
        didSet {
            block02.onTap = {
                self.tapped(x: 0, y: 2)
            }
        }
    }
    
    @IBOutlet private weak var block10: BlockView! {
        didSet {
            block10.onTap = {
                self.tapped(x: 1, y: 0)
            }
        }
    }
    
    @IBOutlet private weak var block11: BlockView! {
        didSet {
            block11.onTap = {
                self.tapped(x: 1, y: 1)
            }
        }
    }
    
    @IBOutlet private weak var block12: BlockView! {
        didSet {
            block12.onTap = {
                self.tapped(x: 1, y: 2)
            }
        }
    }
    
    @IBOutlet private weak var block20: BlockView! {
        didSet {
            block20.onTap = {
                self.tapped(x: 2, y: 0)
            }
        }
    }
    
    @IBOutlet private weak var block21: BlockView! {
        didSet {
            block21.onTap = {
                self.tapped(x: 2, y: 1)
            }
        }
    }
    
    @IBOutlet private weak var block22: BlockView! {
        didSet {
            block22.onTap = {
                self.tapped(x: 2, y: 2)
            }
        }
    }
    
    @IBOutlet private weak var nowPlayingLabel: UILabel! {
        didSet {
            
        }
    }
    
    private lazy var blocks: [[BlockView]] = [
        [block00, block01, block02],
        [block10, block11, block12],
        [block20, block21, block22]
    ]
    
    // ===================== TicTacToe Manager ========================
    
    private var nowPlaying: XO = .none {
        didSet {

        }
    }
    
    private var boardStatus: BoardStatus = .available

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowPlaying = .x
    }

    private func tapped(x: Int, y: Int) {
        guard blocks[x][y].isEmpty(), case .available = boardStatus else { return }
        
        blocks[x][y].set(xo: nowPlaying)
        
        boardStatus = evaluate()
        
        switch boardStatus {
        case .xWon(let boardLine):
            mark(for: boardLine)
            resetBtn.isHidden = false
            return
        case .oWon(let boardLine):
            mark(for: boardLine)
            resetBtn.isHidden = false
            return
        case .draw:
            resetBtn.isHidden = false
            return
        case .available:
            break
            // do nothing
        }
        
        if nowPlaying == .x {
            nowPlaying = .o
        } else if nowPlaying == .o {
            nowPlaying = .x
        }
    }
    
    private func mark(for line: BoardLine) {
        switch line {
        case .row(let boardIndex):
            for i in 0...2 {
                blocks[boardIndex.rawValue][i].mark()
            }
        case .col(let boardIndex):
            for i in 0...2 {
                blocks[i][boardIndex.rawValue].mark()
            }
        case .diagonalLTR:
            block00.mark()
            block11.mark()
            block22.mark()
        case .diagonalRTL:
            block02.mark()
            block11.mark()
            block20.mark()
        }
    }
    
    private func evaluate() -> BoardStatus {
        // verify rows
        for i in 0...2 {
            var isWinner = true
            for j in 1...2 {
                if blocks[i][j].placement != blocks[i][0].placement {
                    isWinner = false
                    break
                }
            }
            
            if isWinner {
                if blocks[i][0].placement == .x {
                    return .xWon(.row(BoardIndex.init(rawValue: i)!))
                } else if blocks[i][0].placement == .o {
                    return .oWon(.row(BoardIndex.init(rawValue: i)!))
                }
            }
        }
        
        // verify cols
        for i in 0...2 {
            var isWinner = true
            for j in 1...2 {
                if blocks[j][i].placement != blocks[0][i].placement {
                    isWinner = false
                    break
                }
            }
            
            if isWinner {
                if blocks[0][i].placement == .x {
                    return .xWon(.col(BoardIndex.init(rawValue: i)!))
                } else if blocks[0][i].placement == .o {
                    return .oWon(.col(BoardIndex.init(rawValue: i)!))
                }
            }
        }
        
        // diagonalLTR
        if block00.placement == block11.placement && block00.placement == block22.placement {
            if block00.placement == .x {
                return .xWon(.diagonalLTR)
            } else if block00.placement == .o {
                return .oWon(.diagonalLTR)
            }
         }
        
        // diagonalRTL
        if block02.placement == block11.placement && block02.placement == block20.placement {
            if block02.placement == .x {
                return .xWon(.diagonalRTL)
            } else if block02.placement == .o {
                return .oWon(.diagonalRTL)
            }
        }
        
        for i in 0...2 {
            for j in 0...2 {
                if blocks[i][j].placement == .none {
                    return .available
                }
            }
        }
        
        return .draw
    }
    
    @objc
    private func reset() {
        resetBtn.isHidden = true
        nowPlaying = .x
        boardStatus = .available
        
        for i in 0...2 {
            for j in 0...2 {
                blocks[i][j].reset()
            }
        }
    }
}

enum BoardIndex: Int {
    case zero = 0
    case one = 1
    case two = 2
}

enum BoardLine {
    case row(BoardIndex)
    case col(BoardIndex)
    case diagonalLTR
    case diagonalRTL
}

enum BoardStatus {
    case xWon(BoardLine)
    case oWon(BoardLine)
    case draw
    case available
}

enum BoardFullError: Error {
    case boardIsFull
}
