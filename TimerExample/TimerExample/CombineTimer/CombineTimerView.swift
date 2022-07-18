//
//  CombineTimerView.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/18.
//

import Foundation
import UIKit
import Combine
import SnapKit
import Then

class CombineTimerView: UIView {
    var cancellables = Set<AnyCancellable>()
    var timer: Cancellable?,
        remainingTime = Int()
    let timerView = TimerView()
    
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
        timerView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func bind() {
        timerView.startButton
            .publisher(for: .touchUpInside)
            .filter{ [unowned self] _ in Int(timerView.countTextField.text ?? "") ?? 0 != 0 }
            .sink { [unowned self] _ in
                remainingTime = Int(timerView.countTextField.text ?? "") ?? 0
                timerStart()
            }.store(in: &cancellables)
    }
    
    private func timerStart() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .scan(0, { counter, _ in counter + 1 })
            .filter{ [unowned self] counter in remainingTime - counter >= 0 }
            .sink() { [unowned self] counter in timerView.remainingTime.text =  makeTimeStr(remainingTime - counter) }
    }
    
    private func makeTimeStr(_ time: Int) -> String {
        let hours = time / 3600,
            minutes = time / 60 % 60,
            second = time % 60,
            timeStr = String(format:"%02i:%02i:%02i", hours, minutes, second)
        
        return timeStr
    }
    
    deinit {
        print("CombineTimerView deinit")
    }
}
