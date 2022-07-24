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
    
    var timer: Timer?
    
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
    
    let backButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("exit", for: .normal)
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
        [rockLabel, paperLabel, scissorsLabel, startButton, backButton].forEach(addSubview)
    }
    
    override func setConstraints() {
        rockLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        paperLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        scissorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalTo(startButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.height.equalTo(startButton)
        }
    }
    
    override func bind() {
        setTapGesture()
        setCocoaTap()
    }
    
    private func gameStart() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(rockpaperScissors), userInfo: nil, repeats: true)
    }
    
    private func setCocoaTap() {
        startButton.rx.tap
            .filter{ [weak self] _ in self?.timer == nil }
            .bind { [weak self] in
                self?.gameStart()
            }.disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind { [weak self] in
                self?.timerStop()
                self?.removeFromSuperview()
            }.disposed(by: disposeBag)
    }
    
    private func setTapGesture() {
        let rockTap = UITapGestureRecognizer(),
            paperTap = UITapGestureRecognizer(),
            scissorsTap = UITapGestureRecognizer()
        rockLabel.addGestureRecognizer(rockTap)
        paperLabel.addGestureRecognizer(paperTap)
        scissorsLabel.addGestureRecognizer(scissorsTap)
        
        rockTap.rx.event
            .bind { [unowned self]_ in
                self.timer?.invalidate()
                self.timer = nil
                print("rockTap")
            }.disposed(by: disposeBag)
        
        paperTap.rx.event
            .bind { [unowned self]_ in
                self.timer?.invalidate()
                self.timer = nil
                print("paperTap")
            }.disposed(by: disposeBag)
        
        scissorsTap.rx.event
            .bind { [unowned self]_ in
                self.timer?.invalidate()
                self.timer = nil
                print("scissors")
            }.disposed(by: disposeBag)
    }
    
    private func timerStop() {
        timer?.invalidate()
        timer = nil
    }
}

extension RockPaperScissorsView {
    @objc func rockpaperScissors() {
        guard let randomView = [scissorsLabel, paperLabel, rockLabel].randomElement() else { return }
        
        bringSubviewToFront(randomView)
    }
}
