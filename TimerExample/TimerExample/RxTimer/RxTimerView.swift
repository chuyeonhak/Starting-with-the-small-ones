//
//  RxTimerView.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/18.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa
import Then

class RxTimerView: UIView {
    let disposeBag = DisposeBag(),
        timerView = TimerView()
    
    var viewModel: RxTimerViewModel?
    
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
        bind()
    }
    
    private func addComponent() {
        self.backgroundColor = .white
        addSubview(timerView)
    }
    
    private func setConstraints() {
        timerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        let input = RxTimerViewModel.Input(remainingTime: timerView.startButton.rx.tap
            .take(1)
            .filter{ [unowned self] in timerView.countTextField.text?.isEmpty == false && (Int(timerView.countTextField.text!) ?? 0) > 0 }
            .map { [unowned self] in timerView.countTextField.text! }),
        viewModel = RxTimerViewModel(input: input)
        
        self.viewModel = viewModel
        
        viewModel.output?.timeCount
            .drive(timerView.remainingTime.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output?.timeOver
            .drive { [unowned self] _ in bind(); print("timeover") }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("RxTimerView deinit")
    }
}
