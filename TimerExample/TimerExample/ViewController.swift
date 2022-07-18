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
    let disposeBag = DisposeBag()
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let swiftTimerButton = UIButton().then {
        $0.setTitle("swiftTimerView", for: .normal)
        $0.setTitleColor(UIColor.blue, for: .normal)
    }
    
    let rxTimerButton = UIButton().then {
        $0.setTitle("RxTimerView", for: .normal)
        $0.setTitleColor(UIColor.orange, for: .normal)
    }
    
    let combineTimerButton = UIButton().then {
        $0.setTitle("swiftTimerView", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
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
        view.addSubview(stackView)
        
        [swiftTimerButton, rxTimerButton, combineTimerButton].forEach(stackView.addArrangedSubview)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    private func bind() {
        swiftTimerButton.rx.tap
            .bind { [weak self] in
                self?.addSubView(view: SwiftTimerView())
            }.disposed(by: disposeBag)
        
        rxTimerButton.rx.tap
            .bind { [weak self] in
                self?.addSubView(view: RxTimerView())
            }.disposed(by: disposeBag)
        
        combineTimerButton.rx.tap
            .bind {
                
            }.disposed(by: disposeBag)
    }
    
    private func addSubView<T: UIView>(view: T) {
        self.view.addSubview(view)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

