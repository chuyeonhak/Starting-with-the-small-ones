//
//  RockPaperScissorsViewModel.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/22.
//

import Foundation
import RxSwift
import RxCocoa

class RockPaperScissorsViewModel: ViewModel {
    enum GameState {
        case isPlaying
        case ready
    }
    var model = Model()
    var input: Input?
    var output: Output?
    var disposeBag = DisposeBag()
    
    var deinitPrinter = DeinitPrinter()
    
    struct Model {
        let toastMessage = PublishSubject<String>()
        let gameState = BehaviorRelay<GameState>(value: .ready)
        let winningStreak = BehaviorRelay<Int>(value: 0)
    }
    
    struct Input {
        let startButtonTapped: Observable<Void>
        let userTapped: Observable<(Int?, Int?)>
    }
    
    struct Output {
        let gameState: Driver<GameState>
    }
    
    required init(input: Input) {
        input.startButtonTapped
            .filter{ [unowned self] in isPlaying(isStartButtonTap: true) }
            .bind { [weak self] in self?.model.gameState.accept(.isPlaying) }
            .disposed(by: disposeBag)
        
        input.userTapped
            .filter{ [unowned self] _ in !isPlaying() }
            .bind { [weak self] in self?.pickWinner(computer: $0.0, user: $0.1) }
            .disposed(by: disposeBag)
        
        output = Output(gameState: model.gameState.asDriverOnErrorEmpty())
    }
    
    private func isPlaying(isStartButtonTap: Bool = false) -> Bool {
        switch model.gameState.value {
        case .isPlaying where isStartButtonTap: model.toastMessage.onNext("현재 게임중 입니다."); return false
        case .ready where !isStartButtonTap: model.toastMessage.onNext("startButton을 눌러주세요!"); return true
        default: return isStartButtonTap
        }
    }
    
    private func pickWinner(computer: Int?, user: Int?) {
        guard let computer = computer, let user = user else { return }
        model.gameState.accept(.ready)
        let computerNum = computer % 10,
            userNum = user % 10,
            winningStreak = model.winningStreak.value
        
        switch (computerNum, userNum) {
        case (let com, let user) where com == user: print("draw")
        case (3, 5), (5, 7), (7, 3): print("user Win"); model.winningStreak.accept(winningStreak + 1)
        case (5, 3), (7, 5), (3, 7) : print("computer Win"); model.winningStreak.accept(0)
        default: break
        }
    }
}
