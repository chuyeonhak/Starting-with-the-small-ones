//
//  Extension + UIViewController.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String?, message: String?, options: (title: String, style: UIAlertAction.Style)..., completion: ((String) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option.title, style: option.style, handler: { _ in
                completion?(options[index].title)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
