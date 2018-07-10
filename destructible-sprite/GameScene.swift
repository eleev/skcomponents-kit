//
//  GameScene.swift
//  destructible-sprite
//
//  Created by Astemir Eleev on 10/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PhysicsCategories: UInt32 {
    case ball = 2
    case ground = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Properties
    
    var groundNode: DestructibleSpriteNode?
    
    // MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        groundNode = DestructibleSpriteNode(imageNamed: "brick wall")
        groundNode?.position = CGPoint(x: 0, y: -view.frame.height / 2)
        self.addChild(groundNode!)
        
        self.physicsWorld.contactDelegate = self
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        createBallNode(at: location)
    }
   
    // MARK: - Physics Contact Delegate conformance
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == PhysicsCategories.ball.rawValue, let ballNode = contact.bodyA.node as? SKShapeNode {
           hitTest(ball: ballNode, contact: contact)
        } else if contact.bodyB.categoryBitMask == PhysicsCategories.ball.rawValue, let ballNode = contact.bodyB.node as? SKShapeNode {
           hitTest(ball: ballNode, contact: contact)
        }
    }
    
    // MARK: - Private helpers
    
    private func hitTest(ball: SKShapeNode, contact: SKPhysicsContact) {
        let objectSize = CGSize(width: 50, height: 50)
        let buildingLocation = convert(contact.contactPoint, to: groundNode!)
        groundNode?.hitAt(point: buildingLocation, objectSize: objectSize)
        
        ball.removeFromParent()
    }
    
    private func createBallNode(at location: CGPoint) {
        let radius: CGFloat = 20
        
        let ballNode = SKShapeNode(circleOfRadius: radius)
        ballNode.fillColor = .clear
        ballNode.strokeColor = .white
        ballNode.lineWidth = 2.0
        ballNode.position = location
        
        
        let physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody.affectedByGravity = true
        physicsBody.categoryBitMask = PhysicsCategories.ball.rawValue
        physicsBody.contactTestBitMask = PhysicsCategories.ground.rawValue
        ballNode.physicsBody = physicsBody
        
        self.addChild(ballNode)
    }
}
