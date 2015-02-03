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
    
    override func didMoveToView(view: SKView) {
        var bgTexture   = SKTexture(imageNamed: "img/bg.png")
        
        var movebg          = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replacebg       = SKAction.moveByX(900, y: 0, duration: 0)
        var movebgForever   = SKAction.repeatActionForever(movebg)
        
        for var i:CGFloat=0; i<3; i++ {
            bg              = SKSpriteNode(texture: bgTexture)
            bg.position     = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            bg.size.height  = self.frame.height
            
            bg.runAction(movebgForever)
            
            self.addChild(bg)
        }
        
        var birdTexture = SKTexture(imageNamed: "img/flappy1.png")
        var birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        var animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        var makeBirdFlap = SKAction.repeatActionForever(animation)
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        self.addChild(bird)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
