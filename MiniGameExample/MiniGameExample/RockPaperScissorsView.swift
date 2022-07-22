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
    let rockLabel = UIView().then {
        $0.backgroundColor = .red
    }
    
    let paperLabel = UIView().then {
        $0.backgroundColor = .blue
    }
    
    let scissorsLabel = UIView().then {
        $0.backgroundColor = .yellow
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
        [rockLabel, paperLabel, scissorsLabel].forEach(addSubview)
    }
    
    override func setConstraints() {
        rockLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(5)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        paperLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(rockLabel.snp.trailing).inset(5)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        scissorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(paperLabel.snp.trailing).inset(5)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
    }
    
    override func bind() {
        let rockTap = UITapGestureRecognizer(),
            paperTap = UITapGestureRecognizer(),
            sissorsTap = UITapGestureRecognizer()
        rockLabel.addGestureRecognizer(rockTap)
        paperLabel.addGestureRecognizer(paperTap)
        scissorsLabel.addGestureRecognizer(sissorsTap)
        
        rockTap.rx.event
            .bind { [unowned self]_ in
                print(rockLabel.bounds)
            }.disposed(by: disposeBag)
        
        paperTap.rx.event
            .bind { [unowned self]_ in
                print(paperLabel.bounds)
            }.disposed(by: disposeBag)
        
        sissorsTap.rx.event
            .bind { [unowned self]_ in
                print(scissorsLabel.bounds)
            }.disposed(by: disposeBag)
    }
}
