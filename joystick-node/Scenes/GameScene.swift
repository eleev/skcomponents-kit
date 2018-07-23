//
//  GameScene.swift
//  joystick-node
//
//  Created by Astemir Eleev on 23/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties
    
    private var tankNode : SKSpriteNode?
    
    lazy var joystickMovement: Joystick = {
        let joystick = Joystick()
        joystick.zPosition = 100
        joystick.xScale = 2.0
        joystick.yScale = 2.0
        return joystick
    }()
    
    lazy var joystickRotation: Joystick = {
        let joystick = Joystick()
        joystick.zPosition = 100
        joystick.xScale = 1.8
        joystick.yScale = 1.8
        return joystick
    }()
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        tankNode = self.childNode(withName: "//Tank") as? SKSpriteNode
        
        guard let tankNode = self.tankNode else {
            return
        }
        
        // You need to attack the target node to the joystick in order to be able to use it
        joystickMovement.attach(moveControllable: tankNode)
        // If you need to control only the position or just orientation - use the corresponding attach method
        joystickRotation.attach(rotateControllable: tankNode)
        
        // The next step is to properly position the joystick
        let controlYPosition = -(scene?.view?.bounds.height)! / 2.5
        joystickMovement.position = CGPoint(x: -(scene?.view?.bounds.width)! / 2.5, y: controlYPosition)
        // And finally add it as a child node of the Scene's root node
        addChild(joystickMovement)
        
        joystickRotation.position = CGPoint(x: (scene?.view?.bounds.width)! / 2.5, y: controlYPosition)
        addChild(joystickRotation)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Finally the joystick needs to be updated in order to properly function
        joystickMovement.update(currentTime)
        joystickRotation.update(currentTime)

    }
}

// Adds conformance to Controllable2D protocol which already has a number of protocol extensions, so it is not mandatory to implement the conformance
extension SKSpriteNode: Controllable2D {
    
    func rotate(for angularVelocity: CGFloat) {
        // Delegate the operation to the protocol extnesion method that provides the default implementation for rotation
        rotate(node: self, using: angularVelocity, with: 0.3, timingMode: .linear, shouldInverse: false)
    }
    
    func move(for velocity: CGPoint) {
        // Delegate the operation to the protocol extnesion method that provides the default implementation for movement
        move(node: self, using: velocity, with: 0.3, timingMode: .linear)
    }
}
