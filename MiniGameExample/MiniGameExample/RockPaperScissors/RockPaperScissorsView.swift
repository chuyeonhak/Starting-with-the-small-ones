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
import Toast
import CoreData

class RockPaperScissorsView: ReactivableView {
    var viewModel: RockPaperScissorsViewModel?
    
    var timer: Timer?
    
    let rockLabel = UIView().then {
        let imageView = UIImageView()
        imageView.image = Const.Asset.rock.image
        $0.addSubview(imageView)
        
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        $0.backgroundColor = .white
        $0.tag = 33
    }
    
    let paperLabel = UIView().then {
        let imageView = UIImageView()
        imageView.image = Const.Asset.paper.image
        $0.addSubview(imageView)
        
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        $0.backgroundColor = .white
        $0.tag = 35
    }
    
    let scissorsLabel = UIView().then {
        let imageView = UIImageView()
        imageView.image = Const.Asset.scissors.image
        
        $0.addSubview(imageView)
        
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        $0.backgroundColor = .white
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
        let image = Const.Asset.rock.image
        $0.setImage(image, for: .normal)
        $0.tag = 23
        $0.adjustsImageWhenHighlighted = false
    }
    
    let userPaper = UIButton().then {
        let image = Const.Asset.paper.image
        $0.setImage(image, for: .normal)
        $0.tag = 25
        $0.adjustsImageWhenHighlighted = false
    }
    
    let userScissors = UIButton().then {
        let image = Const.Asset.scissors.image
        $0.setImage(image, for: .normal)
        $0.tag = 27
        $0.adjustsImageWhenHighlighted = false
    }
    
    let greatestWinningLabel = UILabel().then {
        $0.text = "최대 0연승"
    }
    
    let currentWinningLabel = UILabel().then {
        $0.text = "현재 0연승"
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
        [rockLabel, paperLabel, scissorsLabel, startButton, backButton, userSelectView, greatestWinningLabel, currentWinningLabel].forEach(addSubview)
        
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
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
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
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(startButton.snp.top).inset(-16)
            $0.height.equalTo((UIScreen.main.bounds.width - 32.0) / 3)
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
        
        greatestWinningLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        currentWinningLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(greatestWinningLabel.snp.bottom)
        }
    }
    
    override func bind() {
        setInput()
        setCocoaTap()
    }
    
    private func gameStart() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(rockpaperScissors), userInfo: nil, repeats: true)
    }
    
    private func setCocoaTap() {
        backButton.rx.tap
            .bind { [weak self] in
                self?.timerStop()
                self?.removeFromSuperview()
            }.disposed(by: disposeBag)
    }
    
    private func setInput() {
        let userRockTap = UITapGestureRecognizer(),
            userPaperTap = UITapGestureRecognizer(),
            userScissorsTap = UITapGestureRecognizer()
        
        userRock.addGestureRecognizer(userRockTap)
        userPaper.addGestureRecognizer(userPaperTap)
        userScissors.addGestureRecognizer(userScissorsTap)
        
        let input = RockPaperScissorsViewModel.Input(startButtonTapped: startButton.rx.tap.asObservable(),
                                                     userTapped: Observable.of(userRockTap.rx.event, userPaperTap.rx.event, userScissorsTap.rx.event).merge().map {[unowned self] touch in (subviews.last?.tag, touch.view?.tag)})
        
        viewModel = RockPaperScissorsViewModel(input: input)
        
        viewModel?.model.toastMessage
            .bind { [weak self] message in
                self?.makeToast(message)
            }.disposed(by: disposeBag)
        
        viewModel?.output?.gameState
            .skip(1)
            .drive { [weak self] state in
                switch state {
                case .isPlaying: self?.gameStart()
                case .ready: self?.timerStop()
                }
            }.disposed(by: disposeBag)
        
        viewModel?.output?.greatestWinningStreak
            .map { "최대 \($0)연승" }
            .drive(greatestWinningLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output?.currentWinningStreak
            .map { "현재 \($0)연승"}
            .drive(currentWinningLabel.rx.text)
            .disposed(by: disposeBag)
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
