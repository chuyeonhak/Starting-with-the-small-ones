//
//  Extension + UITextView.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import UIKit

extension UITextView {
    var numberOfLine: Int {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font?.lineHeight ?? 12)) - 1
    }
    
    func maxLength(maxSize: Int, complete: ((Int) -> ())? = nil) {
        if self.text.count > maxSize {
            self.text = String(self.text.prefix(maxSize))
            complete?(maxSize)
        }
    }
    
    func addPlacehoder(text: String, placeholderColor: UIColor? = UIColor(rgb: 102), font: UIFont? = nil) {
        let placeholder = UILabel()
        
        placeholder.tag = 100
        placeholder.text = text
        placeholder.textColor = placeholderColor
        placeholder.font = font ?? self.font
        
        self.addSubview(placeholder)
        
        placeholder.snp.makeConstraints {
            $0.top.equalToSuperview().inset(self.textContainerInset.top)
            $0.leading.equalToSuperview().inset(self.textContainerInset.left + 3)
        }
    }
}
