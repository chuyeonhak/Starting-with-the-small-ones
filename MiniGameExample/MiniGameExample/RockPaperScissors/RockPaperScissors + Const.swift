//
//  RockPaperScissors + Const.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/25.
//

import Foundation
import UIKit

extension RockPaperScissorsView {
    struct Const {
        enum Asset {
            case rock
            case paper
            case scissors
            
            var image: UIImage? {
                switch self {
                case .rock: return UIImage(named: "rock")
                case .paper: return UIImage(named: "paper")
                case .scissors: return UIImage(named: "scissors")
                }
            }
        }

    }
}
