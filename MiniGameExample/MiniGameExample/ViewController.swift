//
//  ViewController.swift
//  MiniGameExample
//
//  Created by chuchu on 2022/07/21.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let miniGameStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    let rockPaperScissorsButton = UIButton().then {
        $0.setImage(UIImage(named: "lockPaperScissors"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    private func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    private func addComponent() {
        view.addSubview(miniGameStackView)
        
        [rockPaperScissorsButton].forEach(miniGameStackView.addArrangedSubview)
    }
    
    private func setConstraints() {
        miniGameStackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        rockPaperScissorsButton.rx.tap
            .bind { [unowned self] in
                addSubView(RockPaperSissorsView())
            }.disposed(by: disposeBag)
    }
    
    private func addSubView(_ view: ReactivableView) {
        self.view.addSubview(view)
        view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
