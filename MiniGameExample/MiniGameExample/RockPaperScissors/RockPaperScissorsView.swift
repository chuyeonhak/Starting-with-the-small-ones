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
    
    var viewModel: RockPaperScissorsViewModel?
    
    var timer: Timer?
    
    let rockLabel = UIView().then {
        $0.backgroundColor = .red
        $0.tag = 33
    }
    
    let paperLabel = UIView().then {
        $0.backgroundColor = .blue
        $0.tag = 35
    }
    
    let scissorsLabel = UIView().then {
        $0.backgroundColor = .yellow
        $0.tag = 37
    }
    
    let startButton = UIButton().then {
        $0.setTitle("Start", for: .normal)
        $0.backgroundColor = .gray
    }
    
    let backButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("exit", for: .normal)
    }
    
    let userSelectView = UIView().then {
        $0.backgroundColor = .black
    }
    
    let userRock = UIButton().then {
        $0.backgroundColor = .red
        $0.tag = 23
    }
    
    let userPaper = UIButton().then {
        $0.backgroundColor = .blue
        $0.tag = 25
    }
    
    let userScissors = UIButton().then {
        $0.backgroundColor = .yellow
        $0.tag = 27
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
        [rockLabel, paperLabel, scissorsLabel, startButton, backButton, userSelectView].forEach(addSubview)
        
        [userRock, userPaper, userScissors].forEach(userSelectView.addSubview)
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
        
        userSelectView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.height.equalTo(startButton)
            $0.trailing.equalTo(startButton.snp.leading).offset(-16.0)
        }
        
        userRock.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        userPaper.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(userRock.snp.trailing)
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        userScissors.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(userPaper.snp.trailing)
            $0.width.equalToSuperview().dividedBy(3)
        }
    }
    
    override func bind() {
        setTapGesture()
        setCocoaTap()
        
        viewModel = RockPaperScissorsViewModel(input: RockPaperScissorsViewModel.Input())
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
            scissorsTap = UITapGestureRecognizer(),
            userRockTap = UITapGestureRecognizer(),
            userPaperTap = UITapGestureRecognizer(),
            userScissorsTap = UITapGestureRecognizer()
        rockLabel.addGestureRecognizer(rockTap)
        paperLabel.addGestureRecognizer(paperTap)
        scissorsLabel.addGestureRecognizer(scissorsTap)
        userRock.addGestureRecognizer(userRockTap)
        userPaper.addGestureRecognizer(userPaperTap)
        userScissors.addGestureRecognizer(userScissorsTap)
        
        Observable.of(userRockTap.rx.event, userPaperTap.rx.event, userScissorsTap.rx.event)
            .merge()
            .bind { [weak self] touch in
                self?.timerStop()
                self?.pickWinner(computer: self?.subviews.last?.tag, user: touch.view?.tag)
            }.disposed(by: disposeBag)
    }
    
    private func timerStop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func pickWinner(computer: Int?, user: Int?) {
        guard let computer = computer, let user = user else { return }
        let computerNum = computer % 10,
            userNum = user % 10
        
        switch (computerNum, userNum) {
        case (let com, let user) where com == user: print("draw")
        case (3, 5), (5, 7), (7, 3): print("user win")
        case (5, 3), (7, 5), (3, 7) : print("computerWin")
        default: print("default는 안 나올거야 \(computerNum) \(userNum)")
        }
    }
}

extension RockPaperScissorsView {
    @objc func rockpaperScissors() {
        guard let randomView = [scissorsLabel, paperLabel, rockLabel].randomElement() else { return }
        
        bringSubviewToFront(randomView)
    }
}
