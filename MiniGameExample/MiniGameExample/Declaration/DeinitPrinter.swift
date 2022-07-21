//
//  DeinitPrinter.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import SnapKit
import Then
import UIKit

class DeinitPrinter: CustomStringConvertible {
    var description: String
    
    init(_ description: String = #file) {
        self.description = description.components(separatedBy: "/").last ?? ""
    }
    
    deinit {
        print("\(description) \(#function)")
    }
}

