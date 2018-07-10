//
//  DestructibleSpriteNode.swift
//  destructible-sprite
//
//  Created by Astemir Eleev on 10/07/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import SpriteKit

class DestructibleSpriteNode: SKSpriteNode {
    
    // MARK: - Properties
    
    private var currentImage: UIImage
    
    // MARK: - Initializers
    
    init(imageNamed: String) {
        guard let currentImage = UIImage(named: imageNamed) else {
            fatalError("Could not instantiate UIImage")
        }
        self.currentImage = currentImage
        let texture = SKTexture(image: self.currentImage)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        configurePhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func hitAt(point: CGPoint, objectSize: CGSize) {
        let size = self.size
        
        let xPoint = point.x + size.width / 2.0
        let yPoint = abs(point.y - (size.height / 2.0))
        let convertedPoint = CGPoint(x: xPoint, y: yPoint)
        
        let width = objectSize.width
        let height = objectSize.height
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let renderedImage = renderer.image { ctx in
            currentImage.draw(at: CGPoint(x: 0, y: 0))
            
            ctx.cgContext.addEllipse(in: CGRect(x: convertedPoint.x - width / 2, y: convertedPoint.y - height / 2, width: width, height: height))
            ctx.cgContext.setBlendMode(.clear)
            ctx.cgContext.drawPath(using: .fill)
        }
        
        texture = SKTexture(image: renderedImage)
        currentImage = renderedImage
        
        configurePhysics()
    }
    
    // MARK: - Private mehtods
    
    private func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.isDynamic = false
        physicsBody?.pinned = true
        physicsBody?.categoryBitMask = PhysicsCategories.ground.rawValue
        physicsBody?.contactTestBitMask = PhysicsCategories.ball.rawValue
    }
}
