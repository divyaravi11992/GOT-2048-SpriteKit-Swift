//
//  BoxNode.swift
//  GOT2048
//
//  Created by Divya Ravi on 02/05/19.
//  Copyright © 2016 Divya Ravi. All rights reserved.
//

import SpriteKit

class BoxNode: SKSpriteNode {
    
    var labelNode: SKLabelNode?
    
    convenience init(blockSize: CGFloat) {
//        let imageName = ImageAssociation.getImageValue(value: Int(pow(Double(2), Double(Int.random(in: 1 ..< 10)))))
//        self.init(imageNamed: imageName)
        self.init()
        labelNode = SKLabelNode(text: "0")
        labelNode?.isHidden = true
        labelNode?.setScale(2.0)
        labelNode?.position = CGPoint(x: labelNode!.frame.midX, y: -labelNode!.frame.midY)
        
        addChild(labelNode!)
    }
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
