//
//  GameScene.swift
//  FlappyBird
//
//  Created by Aleph Retamal on 02/02/15.
//  Copyright (c) 2015 Aleph Retamal. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var bird    = SKSpriteNode()
    var bg      = SKSpriteNode()
    var pipe    = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        var bgTexture   = SKTexture(imageNamed: "img/bg.png")
        
        var movebg          = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replacebg       = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var movebgForever   = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        
        for var i:CGFloat=0; i<3; i++ {
            bg              = SKSpriteNode(texture: bgTexture)
            bg.position     = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            bg.size.height  = self.frame.height
            
            bg.runAction(movebgForever)
            
            self.addChild(bg)
        }
        
        var ground = SKNode()
        ground.position             = CGPointMake(0, 0)
        ground.physicsBody          = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        
        self.addChild(ground)
        
        // Pipes
        
        var pipeTexture1    = SKTexture(imageNamed: "img/pipe1.png")
        var pipeTexture2    = SKTexture(imageNamed: "img/pipe2.png")
        
        pipe                        = SKSpriteNode(texture: pipeTexture1)
        pipe.position               = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame) + pipeTexture1.size().height / 3)
        pipe.physicsBody            = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipeTexture1.size().width, pipeTexture1.size().height))
        pipe.physicsBody?.dynamic   = false
        self.addChild(pipe)
        
        pipe                        = SKSpriteNode(texture: pipeTexture2)
        pipe.position               = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame) - pipeTexture1.size().height / 3)
        pipe.physicsBody            = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipeTexture2.size().width, pipeTexture2.size().height))
        pipe.physicsBody?.dynamic   = false
        self.addChild(pipe)
        
        
        // Bird
        var birdTexture     = SKTexture(imageNamed: "img/flappy1.png")
        var birdTexture2    = SKTexture(imageNamed: "img/flappy2.png")
        var animation       = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        var makeBirdFlap    = SKAction.repeatActionForever(animation)
        bird                = SKSpriteNode(texture: birdTexture)
        bird.position       = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        bird.physicsBody                    = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic           = true
        bird.physicsBody?.allowsRotation    = false
        
        self.addChild(bird)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
