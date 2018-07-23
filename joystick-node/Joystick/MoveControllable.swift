//
//  MoveControllable.swift
//  ios-spritekit-tanks
//
//  Created by Astemir Eleev on 10/06/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

/// Protocol that defines a delegate method that returns a new velocity based on the user inout 
protocol MoveControllable {
    func move(for velocity: CGPoint)
}

extension MoveControllable {
    
    /// Ready-made implementation for node movement. Call this method on its own or using the conformed move(for: CGPoint) method
    ///
    /// - Parameters:
    ///   - node: is a node that will be used to run move action
    ///   - velocity: movement velocity
    ///   - duration: duration that takes to complete one movement step
    ///   - timingMode: is a function that determines the execution of animation
    func move(node: SKNode, using velocity: CGPoint, with duration: TimeInterval = 0.3, timingMode: SKActionTimingMode) {
        let nextPoint = CGPoint(x: node.position.x + 1.0 * velocity.x, y: node.position.y + 1.0 * velocity.y)
        let action = SKAction.move(to: nextPoint, duration: duration)
        action.timingMode = timingMode
        node.run(action)
    }
}
