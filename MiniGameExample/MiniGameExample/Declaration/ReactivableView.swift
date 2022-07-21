//
//  ReactivableView.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import Foundation
import RxSwift
import UIKit

class ReactivableView: UIView, BaseViewProtocol {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.accessibilityIdentifier = #file.components(separatedBy: "/").last ?? ""
        print(accessibilityIdentifier!, #function)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() { }
    func addComponent() { }
    func setConstraints() { }
    func bind() { }
    
    deinit {
        print(accessibilityIdentifier!, #function)
    }
}

protocol BaseViewProtocol: AnyObject {
    func commonInit()
    func addComponent()
    func setConstraints()
    func bind()
}
