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
    
    let clockView = UIImageView().then {
        $0.image = UIImage(named: "clock")
    }
    
    let hourHand = UIView().then {
        $0.backgroundColor = .black
    }
    
    let miniuteHand = UIView().then {
        $0.backgroundColor = .black
    }
    
    let secondHand = UIView().then {
        $0.backgroundColor = .red
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let hourMaskLayer = CALayer(),
            miniuteMaskLayer = CALayer(),
            secondMaskLayer = CALayer()
        
        _ = [hourMaskLayer, miniuteMaskLayer, secondMaskLayer].map { $0.backgroundColor = UIColor.white.cgColor }
        
        hourMaskLayer.frame = CGRect(x: 0, y: 0, width: 2, height: hourHand.bounds.height / 2)
        hourHand.layer.mask = hourMaskLayer
        
        miniuteMaskLayer.frame = CGRect(x: 0, y: 0, width: 2, height: miniuteHand.bounds.height / 2)
        miniuteHand.layer.mask = miniuteMaskLayer
        
        secondMaskLayer.frame = CGRect(x: 0, y: 0, width: 2, height: secondHand.bounds.height / 2)
        secondHand.layer.mask = secondMaskLayer
    }
    
    private func commonInit() {
        addComponent()
        setConstraints()
        setCocoa()
    }
    
    private func addComponent() {
        [backButton, countTextField, startButton, remainingTime, clockView].forEach(addSubview)
        
        [hourHand, miniuteHand, secondHand].forEach(clockView.addSubview)
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
        
        clockView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(32)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        hourHand.snp.makeConstraints {
            $0.width.equalTo(3)
            $0.height.equalToSuperview().inset(56)
            $0.center.equalToSuperview()
        }
        
        miniuteHand.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.height.equalToSuperview().inset(40)
            $0.center.equalToSuperview()
        }
        
        secondHand.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalToSuperview().inset(30)
            $0.center.equalToSuperview()
        }
        
        
    }
    
    private func setCocoa() {
        backButton.rx.tap
            .bind { [unowned self] in
                superview?.removeFromSuperview()
            }.disposed(by: disposeBag)
    }
    
    deinit {
        print("TimerView deinit")
    }
}
