//
//  RockPaperScissorsView.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class RockPaperScissorsView: ReactivableView {
    enum RPSType {
        case rock, paper, scissors
    }
    
    var animator = UIViewPropertyAnimator()
    let rockLabel = UIView().then {
        $0.backgroundColor = .red
    }
    
    let paperLabel = UIView().then {
        $0.backgroundColor = .blue
    }
    
    let scissorsLabel = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    let startButton = UIButton().then {
        $0.setTitle("Start", for: .normal)
        $0.backgroundColor = .gray
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    override func addComponent() {
        self.backgroundColor = .white
        [rockLabel, paperLabel, scissorsLabel, startButton].forEach(addSubview)
    }
    
    override func setConstraints() {
        rockLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview()
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        paperLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(rockLabel.snp.trailing)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        scissorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(paperLabel.snp.trailing)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(50)
            
            
        }
    }
    
    override func bind() {
        setTapGesture()
        setCocoaTap()
    }
    
    private func gameStart() {
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            _ = [self.rockLabel, self.scissorsLabel].map {
                $0.frame.origin.x = 130
                }
        }
        
        let secondAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            self.bringSubviewToFront(self.rockLabel)
        }
        
        firstAnimator ~> secondAnimator
        firstAnimator.startAnimation()
    }
    
    private func setCocoaTap() {
        startButton.rx.tap
            .bind { [weak self] in
                self?.gameStart()
            }.disposed(by: disposeBag)
    }
    
    private func setTapGesture() {
        let rockTap = UITapGestureRecognizer(),
            paperTap = UITapGestureRecognizer(),
            sissorsTap = UITapGestureRecognizer()
        rockLabel.addGestureRecognizer(rockTap)
        paperLabel.addGestureRecognizer(paperTap)
        scissorsLabel.addGestureRecognizer(sissorsTap)
        
        rockTap.rx.event
            .bind { [unowned self]_ in
                print("rockLabel")
            }.disposed(by: disposeBag)
        
        paperTap.rx.event
            .bind { [unowned self]_ in
                print("paperLabel")
            }.disposed(by: disposeBag)
        
        sissorsTap.rx.event
            .bind { [unowned self]_ in
                print("scissorsLabel")
            }.disposed(by: disposeBag)
    }
}
