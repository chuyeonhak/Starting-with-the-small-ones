//
//  RockPaperSissorsView.swift
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

class RockPaperSissorsView: ReactivableView {
    let rockLabel = UIView().then {
        $0.backgroundColor = .red
    }
    
    let paperLabel = UIView().then {
        $0.backgroundColor = .blue
    }
    
    let sissorsLabel = UIView().then {
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
        [rockLabel, paperLabel, sissorsLabel].forEach(addSubview)
    }
    
    override func setConstraints() {
        rockLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview()
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        paperLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(rockLabel.snp.trailing)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
        
        sissorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(paperLabel.snp.trailing)
            $0.size.equalTo(self.snp.width).dividedBy(3)
        }
    }
    
    override func bind() {
        let rockTap = UITapGestureRecognizer(),
            paperTap = UITapGestureRecognizer(),
            sissorsTap = UITapGestureRecognizer()
        rockLabel.addGestureRecognizer(rockTap)
        paperLabel.addGestureRecognizer(paperTap)
        sissorsLabel.addGestureRecognizer(sissorsTap)
        
        rockTap.rx.event
            .bind { _ in
                print("rock")
            }.disposed(by: disposeBag)
        paperTap.rx.event
            .bind { _ in
                print("paper")
            }.disposed(by: disposeBag)
        sissorsTap.rx.event
            .bind { _ in
                print("sissors")
            }.disposed(by: disposeBag)
        
    }
}
