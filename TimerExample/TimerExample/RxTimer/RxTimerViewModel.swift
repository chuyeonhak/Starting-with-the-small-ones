//
//  RxTimerViewModel.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/18.
//

import Foundation
import RxSwift
import RxCocoa

class RxTimerViewModel {
    typealias InputType = Input
    typealias OutputType = Output
    typealias DependencyModelType = Model
    
    let disposeBag = DisposeBag()
    var input: InputType?
    var output: OutputType?
    let model = Model()
    
    init(input: Input) {
        input.remainingTime
            .bind { [unowned self] firstTime in
                let time = Int(firstTime) ?? 0
                model.timeCount.accept(makeTimeStr(time))
                timerStart(time - 1)
            }.disposed(by: disposeBag)
        
        output = Output(timeCount: model.timeCount.asDriverOnErrorEmpty(),
                        timeOver: model.timeOver.asDriverOnErrorEmpty())
    }
    
    private func timerStart(_ firstTime: Int) {
        Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(until: { $0 == firstTime }, behavior: .inclusive)
            .map { [unowned self] in makeTimeStr(firstTime - $0) }
            .bind(to: model.timeCount)
            .disposed(by: disposeBag)
    }
    
    private func makeTimeStr(_ time: Int) -> String {
        let hours = time / 3600,
            minutes = time / 60 % 60,
            second = time % 60,
            timeStr = String(format:"%02i:%02i:%02i", hours, minutes, second)
        
        if time == 0 {
            model.timeOver.onNext(())
        }
        
        return timeStr
    }
    
    deinit {
        print("ViewModel deinit")
    }
}

extension RxTimerViewModel {
    struct Model {
        let timeCount = BehaviorRelay<String>(value: "00:00:00")
        let timeOver = PublishSubject<Void>()
    }
    
    struct Input {
        let remainingTime: Observable<String>
    }
    
    struct Output {
        let timeCount: Driver<String>
        let timeOver: Driver<Void>
    }
}

extension ObservableType {
    func asDriverOnErrorEmpty() -> Driver<Element> {
        return asDriver { (error) in
            return .empty()
        }
    }
}
