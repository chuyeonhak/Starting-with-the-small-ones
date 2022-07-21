//
//  Extension + UITextField.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import UIKit

extension UITextField {
    func changePlaceholderTextColor(placeholderText: String, textColor: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: textColor])
    }

    func maxLength(maxSize: Int, complete: ((Int) -> ())? = nil) {
        guard let `text` = self.text else { return }
        if text.count > maxSize {
            self.text = String(text.prefix(maxSize))
            complete?(maxSize)
        }
    }
}
