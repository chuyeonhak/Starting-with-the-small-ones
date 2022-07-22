//
//  ViewController.swift
//  AnimationPractice
//
//  Created by chuchu on 2022/07/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import SpriteKit

class ViewController: UIViewController {
    enum AnimationState {
        case play
        case pause
        case stop
        
        var title: String {
            switch self {
            case .play: return "재생"
            case .pause: return "멈춰"
            case .stop: return "끝내기"
            }
        }
    }
    private let disposeBag = DisposeBag()
    
    private var animationView: SKView?
    
    let controlButton = UIButton().then {
        $0.setTitle(AnimationState.play.title, for: .normal)
    }
    
    let stopButton = UIButton().then {
        $0.setTitle(AnimationState.stop.title, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        commonInit()
    }

    private func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    private func addComponent() {
        self.view.backgroundColor = .black
        [controlButton, stopButton].forEach(view.addSubview)
    }
    
    private func setConstraints() {
        controlButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(50)
        }
        
        stopButton.snp.makeConstraints {
            $0.leading.equalTo(controlButton.snp.trailing)
            $0.size.bottom.equalTo(controlButton)
        }
    }
    
    private func bind() {
        controlButton.rx.tap
            .bind { [unowned self] in
                switch animationView {
                case nil:
                    let scene = SnowScene()
                    animationView = SKView()
                    
                    guard let animationView = animationView else { return }
                    
                    view.insertSubview(animationView, at: 0)
                    animationView.snp.makeConstraints {
                        $0.edges.equalToSuperview()
                    }
                    
                    animationView.presentScene(scene)
                    controlButton.setTitle(AnimationState.pause.title, for: .normal)
                    
                case _:
                    if animationView?.isPaused == true {
                        animationView?.isPaused = false
                        controlButton.setTitle(AnimationState.pause.title, for: .normal)
                    } else {
                        animationView?.isPaused = true
                        controlButton.setTitle(AnimationState.play.title, for: .normal)
                    }
                }
            }.disposed(by: disposeBag)
        
        stopButton.rx.tap
            .bind { [unowned self] in
                controlButton.setTitle(AnimationState.play.title, for: .normal)
                animationView?.removeFromSuperview()
                animationView = nil
            }.disposed(by: disposeBag)
    }
}
