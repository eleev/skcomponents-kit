//
//  Joystick.swift
//  ios-spritekit-tanks
//
//  Created by Astemir Eleev on 06/06/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation
import SpriteKit

class Joystick: SKNode {
    
    // MARK: - Properties
    
    let kThumbSpringBackDuration: Double =  0.3
    private let backdropNode, thumbNode: SKSpriteNode
    
    private(set)var isTracking: Bool = false {
        didSet {
            let color = isTracking ? SKColor.black : SKColor.white
            colorizeThumbNode(with: color)
        }
    }
    
    private(set) var velocity: CGPoint = .zero
    private(set) var angularVelocity: CGFloat = 0.0
    
    var anchorPoint: CGPoint {
        return .zero
    }
    
    let thumbSize = CGSize(width: 60, height: 60)
    let dpadSize = CGSize(width: 120, height: 120)
    
    private(set) var moveControllable: MoveControllable?
    private(set) var rotateControllable: RotateControllable?
    
    // MARK: - Initiailziers
    
    init(thumbNode: SKSpriteNode = SKSpriteNode(imageNamed: "jaystick-flatDark"), backdropNode: SKSpriteNode = SKSpriteNode(imageNamed: "dpad-flatDark")) {
        
        self.thumbNode = thumbNode
        self.thumbNode.size = thumbSize
        self.thumbNode.zPosition = 10
        
        
        self.backdropNode = backdropNode
        self.backdropNode.zPosition = 5
        self.backdropNode.size = dpadSize
        
        super.init()
        
        self.addChild(self.backdropNode)
        self.addChild(self.thumbNode)
        
        self.isUserInteractionEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setters
    
    func attach(moveControllable: MoveControllable) {
        self.moveControllable = moveControllable
    }
    
    func attach(rotateControllable: RotateControllable) {
        self.rotateControllable = rotateControllable
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint: CGPoint = touch.location(in: self)
            
            if self.isTracking == false, self.thumbNode.frame.contains(touchPoint) {
                self.isTracking = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint: CGPoint = touch.location(in: self)
            
            let powx = pow((Double(touchPoint.x) - Double(self.thumbNode.position.x)), 2)
            let powy = pow((Double(touchPoint.y) - Double(self.thumbNode.position.y)), 2)
            let isInCircle = sqrt(powx + powy)
            
            if self.isTracking == true, isInCircle < Double(self.thumbNode.size.width) {
                
                if sqrtf(powf((Float(touchPoint.x) - Float(self.anchorPoint.x)), 2) + powf((Float(touchPoint.y) - Float(self.anchorPoint.y)), 2)) <= Float(self.thumbNode.size.width) {
                    let moveDifference: CGPoint = CGPoint(x: touchPoint.x - self.anchorPoint.x, y: touchPoint.y - self.anchorPoint.y)
                    self.thumbNode.position = CGPoint(x: self.anchorPoint.x + moveDifference.x, y: self.anchorPoint.y + moveDifference.y)
                } else {
                    let vX: Double = Double(touchPoint.x) - Double(self.anchorPoint.x)
                    let vY: Double = Double(touchPoint.y) - Double(self.anchorPoint.y)
                    let magV: Double = sqrt(vX*vX + vY*vY)
                    let aX: Double = Double(self.anchorPoint.x) + vX / magV * Double(self.thumbNode.size.width)
                    let aY: Double = Double(self.anchorPoint.y) + vY / magV * Double(self.thumbNode.size.width)
                    self.thumbNode.position = CGPoint(x: CGFloat(aX), y: CGFloat(aY))
                }
            }
            self.velocity = CGPoint(x: ((self.thumbNode.position.x - self.anchorPoint.x)), y: ((self.thumbNode.position.y - self.anchorPoint.y)))
            self.angularVelocity = -atan2(self.thumbNode.position.x - self.anchorPoint.x, self.thumbNode.position.y - self.anchorPoint.y)
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetVelocity()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetVelocity()
    }
    
    // MAKR: - Conformance to Updatalble protocol
    
    func update(_ currentTime: TimeInterval) {

        if angularVelocity != 0 {
            rotateControllable?.rotate(for: angularVelocity)
        }
        if velocity.x != 0 || velocity.y != 0 {
            moveControllable?.move(for: velocity)
        }
        
    }
    
    
    // MARK: - Methods
    
    private func resetVelocity() {
        self.isTracking = false
        self.velocity = .zero
        
        let easeOut: SKAction = SKAction.move(to: anchorPoint, duration: kThumbSpringBackDuration)
        easeOut.timingMode = SKActionTimingMode.easeOut
        self.thumbNode.run(easeOut)
    }
    
    private func colorizeThumbNode(with color: SKColor, blendFactor: CGFloat = 0.5, duration: TimeInterval = 0.2) {
        let action = SKAction.colorize(with: color, colorBlendFactor: blendFactor, duration: duration)
        thumbNode.run(action)
    }
    
}
