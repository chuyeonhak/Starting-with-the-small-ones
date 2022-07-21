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

class TestView: ReactivableView {
    let testButton = UIButton().then {
        $0.backgroundColor = .black
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
        self.addSubview(testButton)
    }
    
    override func setConstraints() {
        testButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        testButton.rx.tap
            .bind { [unowned self] in
                removeFromSuperview()
            }.disposed(by: disposeBag)
    }
}

