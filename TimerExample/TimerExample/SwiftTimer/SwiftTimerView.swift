//
//  SwiftTimerView.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/18.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift

class SwiftTimerView: UIView {
    let timerView = TimerView()
    var timer: Timer?,
        remainingTime = Int()
    
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
        timerView.startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
    }
    
    deinit {
        print("swiftTimerView deinit")
    }
}

extension SwiftTimerView {
    @objc func startTimer() {
        guard let timeCount = Int(timerView.countTextField.text ?? "0"), timeCount > 0, timer?.isValid == nil else { return }
        remainingTime = timeCount
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if self.remainingTime == 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                }
                self.timerView.remainingTime.text = self.makeTimeStr(self.remainingTime)
                self.remainingTime -= 1
            }
        })
    }
    
    private func makeTimeStr(_ time: Int) -> String {
        let hours = time / 3600,
            minutes = time / 60 % 60,
            second = time % 60,
            timeStr = String(format:"%02i:%02i:%02i", hours, minutes, second)
        
        return timeStr
    }
}
