//
//  Extension + UIColor.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgb: CGFloat, a: CGFloat = 1.0) {
        let rgb = rgb / 255.0
        self.init(red: rgb, green: rgb, blue: rgb, alpha:a)
    }
}
