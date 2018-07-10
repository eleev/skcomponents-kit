//
//  SpriteRopeNode.swift
//  rope-node-spritekit-ios
//
//  Created by Astemir Eleev on 04/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class SpriteRopeNode: SKSpriteNode {
    
    // MARK: - Initializers
    
    init(nodeTexture: SKTexture) {
        super.init(texture: nodeTexture, color: UIColor(), size: nodeTexture.size())
        
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
