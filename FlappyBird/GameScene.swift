//
//  GameScene.swift
//  FlappyBird
//
//  Created by Aleph Retamal on 02/02/15.
//  Copyright (c) 2015 Aleph Retamal. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let startGameLabel = SKLabelNode(fontNamed:"Helvetica")
    
    var scoreLabel = SKLabelNode(fontNamed:"Helvetica")
    var score = 0
    
    var gameStarted = false
    var bird        = SKSpriteNode()
    var bg          = SKSpriteNode()
    var pipe        = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        startGameLabel.text = "Click To Flap!";
        startGameLabel.fontSize = 40;
        startGameLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + self.frame.height / 4);
        startGameLabel.zPosition = 11
        self.addChild(startGameLabel)
        
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
        
        var roof = SKNode()
        roof.position             = CGPointMake(0, self.frame.height)
        roof.physicsBody          = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        roof.physicsBody?.dynamic = false
        
        self.addChild(roof)
        
        // Bird
        var birdTexture     = SKTexture(imageNamed: "img/flappy1.png")
        var birdTexture2    = SKTexture(imageNamed: "img/flappy2.png")
        var animation       = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        var makeBirdFlap    = SKAction.repeatActionForever(animation)
        bird                = SKSpriteNode(texture: birdTexture)
        bird.position       = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        bird.physicsBody                    = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic           = false
        bird.physicsBody?.allowsRotation    = false

        bird.zPosition = 10
        
        self.addChild(bird)
        
        
        
    }
    
    func spawnPipes() {
        let gapHeight       = bird.size.height * 4
        var movementAmount  = arc4random() % UInt32(self.frame.height / 2)
        var pipeOffset      = CGFloat(movementAmount) - self.frame.size.height / 4
        
        var pipeTexture1    = SKTexture(imageNamed: "img/pipe1.png")
        var pipeTexture2    = SKTexture(imageNamed: "img/pipe2.png")
        
        var movePipes           = SKAction.moveByX(-self.frame.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        var removePipes         = SKAction.removeFromParent()
        var moveAndRemovePipes  = SKAction.repeatActionForever(SKAction.sequence([movePipes, removePipes]))
        
        pipe                        = SKSpriteNode(texture: pipeTexture1)
        pipe.position               = CGPoint(x: CGRectGetMaxX(self.frame) - pipeTexture1.size().width, y: CGRectGetMidY(self.frame) + pipeTexture1.size().height / 2 + gapHeight / 2 + pipeOffset)
        pipe.physicsBody            = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipeTexture1.size().width, pipeTexture1.size().height))
        pipe.physicsBody?.dynamic   = false
        pipe.runAction(moveAndRemovePipes)
        self.addChild(pipe)
        
        pipe                        = SKSpriteNode(texture: pipeTexture2)
        pipe.position               = CGPoint(x: CGRectGetMaxX(self.frame) - pipeTexture1.size().width, y: CGRectGetMidY(self.frame) - pipeTexture1.size().height / 2 - gapHeight / 2 + pipeOffset)
        pipe.physicsBody            = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipeTexture2.size().width, pipeTexture2.size().height))
        pipe.physicsBody?.dynamic   = false
        pipe.runAction(moveAndRemovePipes)
        self.addChild(pipe)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if !gameStarted {
            gameStarted                 = true
            bird.physicsBody?.dynamic   = true
            startGameLabel.removeFromParent()
            var createPipes             = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("spawnPipes"), userInfo: nil, repeats: gameStarted)
            
            startGameLabel.text         = "Score: " + String(score);
            startGameLabel.fontSize     = 40;
            startGameLabel.position     = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - startGameLabel.frame.height * 2);
            startGameLabel.zPosition    = 11
            self.addChild(startGameLabel)
        }
        
        startGameLabel.removeFromParent()
        startGameLabel.text         = "Score: " + String(score);
        self.addChild(startGameLabel)
        
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 60))
        
        score++
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
