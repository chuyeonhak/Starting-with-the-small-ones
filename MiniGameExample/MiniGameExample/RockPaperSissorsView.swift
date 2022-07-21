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
    let rockLabel = UILabel().then {
        $0.text = "주먹"
    }
    
    let paperLabel = UILabel().then {
        $0.text = "가위"
    }
    
    let sissorsLabel = UILabel().then {
        $0.text = "보"
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
            $0.size.equalToSuperview().dividedBy(3).inset(5)
        }
        
        paperLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(rockLabel.snp.trailing)
            $0.size.equalToSuperview().dividedBy(3).inset(5)
        }
        
        sissorsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(paperLabel.snp.trailing)
            $0.size.equalToSuperview().dividedBy(3).inset(5)
        }
    }
    
    override func bind() {
        
    }
}
