//
//  RotateControllable.swift
//  ios-spritekit-tanks
//
//  Created by Astemir Eleev on 10/06/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

/// Protocol that defines a delegate method that returns a new angular velocity based on user's input
protocol RotateControllable {
    func rotate(for angularVelocity: CGFloat)
}

extension RotateControllable {
    
    /// Ready-made implementation for node rotation. Call this method on its own or using the conformed rotate(for: CGFloat) method
    ///
    /// - Parameters:
    ///   - node: is a node that will be used to run rotate action
    ///   - angularVelocity: rotatation angular velocity
    ///   - duration: duration that takes to complete rotation
    ///   - timingMode: is a function that determines the execution of animation
    func rotate(node: SKNode, using angularVelocity: CGFloat, with duration: TimeInterval = 0.3, timingMode: SKActionTimingMode, shouldInverse: Bool = true) {
        var angle = angularVelocity
        
        if shouldInverse {
            angle = CGFloat(Double(angle) - Double.pi)
        }
        
        let action = SKAction.rotate(toAngle: angle, duration: duration, shortestUnitArc: true)
        action.timingMode = timingMode
        node.run(action)
    }
}
