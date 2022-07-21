//
//  Extension + Array.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
