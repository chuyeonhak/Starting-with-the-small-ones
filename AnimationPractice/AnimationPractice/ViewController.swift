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
    private let disposeBag = DisposeBag()
    
    private lazy var animationView = SKView().then {
        let scene = makeScene()
        scene.addChild(snowFlowerImage)
        
        $0.frame.size = scene.size
        $0.presentScene(scene)
    }
    
    private lazy var snowFlowerImage = SKSpriteNode(imageNamed: "snowFlower").then {
        $0.position = CGPoint(x: 0, y: UIScreen.main.bounds.height)
    }
    
    
    let button = UIButton().then {
        $0.setTitle("재생", for: .normal)
    }
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "snowFlower")
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
        [animationView, button, imageView].forEach(view.addSubview)
    }
    
    private func setConstraints() {
        animationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(50)
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    
    private func bind() {
        button.rx.tap
            .bind {
                print("wow")
            }.disposed(by: disposeBag)
    }
}

extension ViewController {
    func makeScene() -> SKScene {
        let minimumDimension = min(view.frame.width, view.frame.height)
        let size = CGSize(width: minimumDimension, height: minimumDimension)
        
        let scene = SKScene(size: size)
        scene.backgroundColor = .black
        return scene
    }
}

extension SKLabelNode {
}
