//
//  GameScene.swift
//  rope-node-spritekit-ios
//
//  Created by Astemir Eleev on 02/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties
    
    private var rope: RopeNode!

    // MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        let attachmentNode = SKSpriteNode(color: .clear, size: CGSize(width: 20, height: 20))
//        attachmentNode.position = CGPoint(x: self.frame.w, y: <#T##CGFloat#>)
        attachmentNode.physicsBody = SKPhysicsBody(rectangleOf: attachmentNode.size)
        attachmentNode.physicsBody?.affectedByGravity = false
        attachmentNode.physicsBody?.isDynamic = false
        
        addChild(attachmentNode)
        
        rope = RopeNode(with: 30, and: SKTexture(imageNamed: "chain_ring"))
        rope.attach(to: attachmentNode)
        rope.attach(anchor: SKTexture(imageNamed: "ball"))
        
        
//        let engeNode = SKNode()
//        engeNode.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        self.addChild(engeNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: - Touch handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let tail = rope.tail {
            let vector = CGVector(dx: 50, dy: 0)
            let point = CGPoint(x: tail.frame.midX, y: tail.frame.midY)
            tail.physicsBody?.applyImpulse(vector, at: point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // has not been implemented
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // has not been implemented
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // has not been implemented
    }
    
}
