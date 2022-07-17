//
//  ViewController.swift
//  TimerExample
//
//  Created by chuchu on 2022/07/17.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: ViewModel?
    
    private let remainingTime = UILabel().then {
        $0.text = "00:00:00"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    private let countTextField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    
    private let startButton = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .green
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
        [remainingTime, countTextField, startButton].forEach(view.addSubview)
    }
    
    private func setConstraints() {
        remainingTime.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        countTextField.snp.makeConstraints {
            $0.top.equalTo(remainingTime.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.equalTo(countTextField.snp.trailing).offset(8)
            $0.centerY.equalTo(countTextField)
            $0.size.equalTo(30)
        }
    }
    
    
    private func bind() {
        let input = ViewModel.Input(remainingTime: startButton.rx.tap
            .take(1)
            .filter{ [unowned self] in countTextField.text?.isEmpty == false }
            .map { [unowned self] in countTextField.text! }),
        viewModel = ViewModel(input: input)
        
        self.viewModel = viewModel
        
        viewModel.output?.timeCount
            .drive(remainingTime.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output?.timeOver
            .drive { [unowned self] _ in bind(); print("timeover") }
            .disposed(by: disposeBag)
    }
    
}

