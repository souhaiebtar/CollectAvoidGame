//
//  GameScene.swift
//  Collect Avoid game
//
//  Created by unknown-macbook on 5/10/16.
//  Copyright (c) 2016 indietarhouni.com. All rights reserved.
//

import SpriteKit

var player = SKSpriteNode?()
var squareCollect = SKSpriteNode?()
var circleAvoid = SKShapeNode?()
var stars = SKSpriteNode?()

struct physicsCategory {
    static let player : UInt32 = 1
    static let squareCollect : UInt32 = 2
    static let circleAvoid : UInt32 = 3
}

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.blackColor()
        
        spawnPlayer()
        spawnSquareCollect()
        spawnCircleAvoid()
        spawnStars()
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    func spawnPlayer(){
        player = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 30, height: 30))
        player?.position = CGPoint(x: self.frame.midX, y: 130)
        player?.physicsBody = SKPhysicsBody(rectangleOfSize: player!.size)
        player?.physicsBody?.affectedByGravity = false
        player?.physicsBody?.categoryBitMask = physicsCategory.player
        player?.physicsBody?.dynamic = false
        
        self.addChild(player!)
    }
    
    func spawnSquareCollect(){
        squareCollect = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 50, height: 50))
        squareCollect?.position = CGPoint(x: self.frame.midX, y: 600)
        squareCollect?.physicsBody = SKPhysicsBody(rectangleOfSize: squareCollect!.size)
        squareCollect?.physicsBody?.affectedByGravity = false
        squareCollect?.physicsBody?.categoryBitMask = physicsCategory.squareCollect
        squareCollect?.physicsBody?.dynamic = true
        
        self.addChild(squareCollect!)

        
    }
    
    func spawnCircleAvoid(){
        circleAvoid = SKShapeNode(circleOfRadius: 15)
        circleAvoid?.strokeColor = UIColor(white: 0, alpha: 0)
        circleAvoid?.fillColor = UIColor.orangeColor()
        
        circleAvoid?.position = CGPoint(x: 400, y: 400)
        
        self.addChild(circleAvoid!)
    }
    
    func spawnStars(){
        stars = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: 10, height: 10))
        stars?.position = CGPoint(x: self.frame.midX, y: 500)
        stars?.zPosition = -1
        
        self.addChild(stars!)
        

    }
    
    
}
