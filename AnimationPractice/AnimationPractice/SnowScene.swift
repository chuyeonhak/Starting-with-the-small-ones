//
//  SnowScene.swift
//  AnimationPractice
//
//  Created by chuchu on 2022/07/22.
//

import Foundation
import UIKit
import SpriteKit
import Then

class SnowScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        setScene(view)
        setSnowNode()
    }
    
    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }
    
    private func setScene(_ view: SKView) {
        backgroundColor = .clear
        scene?.anchorPoint = CGPoint(x: 0.5, y: 1)
        scene?.scaleMode = .aspectFill
    }
    
    private func setSnowNode() {
        guard let snowNode = SKEmitterNode(fileNamed: "Snow") else { return }
        snowNode.position = .zero
        scene?.addChild(snowNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        scene?.s
    }
}
