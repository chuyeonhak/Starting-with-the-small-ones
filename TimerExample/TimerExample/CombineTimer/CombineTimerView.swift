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
            .sink { [unowned self] _ in
                print("setting Combine Touch Event")
            }.store(in: &cancellables)
    }
    
    deinit {
        print("CombineTimerView deinit")
    }
}
