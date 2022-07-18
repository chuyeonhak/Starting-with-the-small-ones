//
//  TimerView.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/18.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift

class TimerView: UIView {
    let disposeBag = DisposeBag()
    
    let backButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .black
    }
    let countTextField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    
    let startButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .green
    }
    
    let remainingTime = UILabel().then {
        $0.text = "00:00:00"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addComponent()
        setConstraints()
        setCocoa()
    }
    
    private func addComponent() {
        [backButton, countTextField, startButton, remainingTime].forEach(addSubview)
    }
    
    private func setConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(30)
        }
        remainingTime.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        countTextField.snp.makeConstraints {
            $0.top.equalTo(remainingTime.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.equalTo(countTextField.snp.trailing).offset(8)
            $0.centerY.equalTo(countTextField)
            $0.size.equalTo(30)
        }
    }
    
    private func setCocoa() {
        backButton.rx.tap
            .bind { [unowned self] in
//                removeFromSuperview()
                superview?.removeFromSuperview()
            }.disposed(by: disposeBag)
    }
    
    deinit {
        print("TimerView deinit")
    }
}
