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

var squareSpeed = 1.5
var circleSpeed = 2.0

var isAlive = true


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
        
        squareSpawnTimer()
        circleSpawnTimer()
        starsSpawnTimer()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            
            if isAlive == true{
                
                player?.position.x = location.x
            }
            if isAlive == false{
                player?.position.x = -200
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if isAlive == false{
            player?.position.x = -200
        }
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
        //squareCollect?.physicsBody?.allowsRotation = false // disable rotation when it collide
        
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
        var randomSize = Int(arc4random_uniform(3)+1)
        
        let randomSpeed : Double = Double(arc4random_uniform(2) + 1)
        
        stars = SKSpriteNode(color: UIColor.whiteColor(), size: CGSize(width: randomSize, height: randomSize))
        //stars?.position = CGPoint(x: self.frame.midX, y: 500)//working
        stars?.position = CGPoint(x: Int(arc4random_uniform(700) + 300), y: 800)
        stars?.zPosition = -1
        
        var moveForward = SKAction.moveToY(-100, duration: randomSpeed )
        let destroy = SKAction.removeFromParent()
        
        stars?.runAction(SKAction.sequence([moveForward, destroy]))
        
        self.addChild(stars!)
        

    }
    
    func squareSpawnTimer(){
        //let squareSpawnTime : Double = Double(arc4random_uniform(1))

        let squareTimer = SKAction.waitForDuration(1.0)
        let spawn = SKAction.runBlock{
            self.spawnSquareCollect()
        }
        
        let sequence = SKAction.sequence([squareTimer, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    func circleSpawnTimer(){
        //let circleSpawnTime : Double = Double(arc4random_uniform(1))
        
        let circleTimer = SKAction.waitForDuration(0.5)
        let spawn = SKAction.runBlock{
            self.spawnCircleAvoid()
        }
        
        let sequence = SKAction.sequence([circleTimer, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    func starsSpawnTimer(){
        //let starSpawnTime : Double = Double(arc4random_uniform(1))
        
        let starTimer = SKAction.waitForDuration(0.05)
        let spawn = SKAction.runBlock{
            self.spawnStars()
        }
        
        let sequence = SKAction.sequence([starTimer, spawn])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
}
