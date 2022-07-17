//
//  ViewController.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/17.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    private let timerLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    private func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    private func addComponent() {
        print(#function)
    }
    
    private func setConstraints() {
        print(#function)
    }
    
    private func bind() {
        print(#function)
    }
}

