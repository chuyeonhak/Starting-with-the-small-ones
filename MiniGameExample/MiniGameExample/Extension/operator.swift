//
//  operator.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/22.
//

import Foundation
import UIKit

infix operator ~>: AdditionPrecedence

@discardableResult
func ~>(left: UIViewPropertyAnimator, right: UIViewPropertyAnimator) -> UIViewPropertyAnimator {
    left.addCompletion { _ in
        right.startAnimation()
    }
    return right
}
