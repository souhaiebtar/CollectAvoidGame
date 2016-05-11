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

var squareSpeed = 0.9
var circleSpeed = 0.9


struct physicsCategory{
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
        //squareCollect?.position = CGPoint(x: self.frame.midX, y: 600)
        squareCollect?.position = CGPoint(x: Int(arc4random_uniform(700)+300), y: 800)
    
        var moveForward = SKAction.moveToY(-100, duration: squareSpeed)
        let destroy = SKAction.removeFromParent()
        squareCollect?.physicsBody = SKPhysicsBody(rectangleOfSize: squareCollect!.size)
        squareCollect?.physicsBody?.affectedByGravity = false
        squareCollect?.physicsBody?.categoryBitMask = physicsCategory.squareCollect
        squareCollect?.physicsBody?.dynamic = true
        
        
        squareCollect?.runAction(SKAction.sequence([moveForward, destroy]))
        self.addChild(squareCollect!)

        
    }
    
    func spawnCircleAvoid(){
        circleAvoid = SKShapeNode(circleOfRadius: 15)
        circleAvoid?.strokeColor = UIColor(white: 0, alpha: 0)
        circleAvoid?.fillColor = UIColor.orangeColor()
        
        circleAvoid?.position = CGPoint(x: Int(arc4random_uniform(700) + 300), y: 800)
        
        circleAvoid?.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        circleAvoid?.physicsBody?.affectedByGravity = false
        circleAvoid?.physicsBody?.categoryBitMask = physicsCategory.circleAvoid
        circleAvoid?.physicsBody?.dynamic = true
        
        
        var moveForward = SKAction.moveToY(-100, duration: circleSpeed)
        let destroy = SKAction.removeFromParent()
        
        circleAvoid?.runAction(SKAction.sequence([moveForward, destroy]))
        
        self.addChild(circleAvoid!)
    }
    
    func spawnStars(){
        var randomSize = Int(arc4random_uniform(8)+1)
        
        let randomSpeed : Double = Double(arc4random_uniform(2) + 1)
        
        stars = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: randomSize, height: randomSize))
        stars?.position = CGPoint(x: self.frame.midX, y: 500)
        stars?.zPosition = -1
        
        var moveForward = SKAction.moveToY(-100, duration: randomSpeed )
        let destroy = SKAction.removeFromParent()
        
        stars?.runAction(SKAction.sequence([moveForward, destroy]))
        
        self.addChild(stars!)
        

    }
    
    
}
