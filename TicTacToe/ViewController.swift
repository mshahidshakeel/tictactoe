//
//  ViewController.swift
//  TicTacToe
//
//  Created by devx on 05/06/2022.
//

import UIKit

class ViewController: UIViewController {
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
            self.nowPlayingLabel.text = nowPlaying.rawValue
        }
    }
    
    // private var board: [[XO]] = Array(repeating: Array(repeating: .none, count: 3), count: 3)
    
    // ==================== Lifecycle Manager =========================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowPlaying = .x
    }

    private func tapped(x: Int, y: Int) {
        guard blocks[x][y].isEmpty() else { return }
        
        blocks[x][y].set(xo: nowPlaying)
        
        do {
            let winner = try checkWinner()
            
            if winner != .none {
                self.nowPlayingLabel.text = "Winner is \(winner.rawValue.uppercased())"
                return
            }
        } catch {
            self.nowPlayingLabel.text = "DRAW"
        }
        
        if nowPlaying == .x {
            nowPlaying = .o
        } else if nowPlaying == .o {
            nowPlaying = .x
        }
    }

    private func checkWinner() throws -> XO {
        // left to right
        for i in 0..<3 {
            if [XO.x, XO.o].contains(blocks[i][0].placement) {
                if blocks[i][0].placement == blocks[i][1].placement,
                   blocks[i][0].placement == blocks[i][2].placement {
                    return blocks[i][0].placement
                }
            }
        }
        
        // top to bottom
        for i in 0..<3 {
            if [XO.x, XO.o].contains(blocks[0][i].placement) {
                if blocks[0][i].placement == blocks[1][i].placement,
                   blocks[0][i].placement == blocks[2][i].placement {
                    return blocks[0][i].placement
                }
            }
        }
        
        // left top to right bottom diagonal
        if blocks[0][0].placement == blocks[1][1].placement,
           blocks[0][0].placement == blocks[2][2].placement {
            return blocks[0][0].placement
        }
        
        // top right to left bottom fiagonal
        if blocks[0][2].placement == blocks[1][1].placement,
           blocks[0][2].placement == blocks[2][0].placement {
            return blocks[0][0].placement
        }
        
        for row in blocks {
            if row.filter({ $0.placement == .none }).count != 0 {
                return .none
            }
        }
        
        throw BoardFullError.boardIsFull
    }
}

enum BoardFullError: Error {
    case boardIsFull
}
