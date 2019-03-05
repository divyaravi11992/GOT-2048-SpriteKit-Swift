//
//  BoxNode.swift
//  GOT2048
//
//  Created by Divya Ravi on 02/05/19.
//  Copyright © 2016 Divya Ravi. All rights reserved.
//

import SpriteKit

class BoxNode: SKSpriteNode {
    
    convenience init(blockSize: CGFloat) {
        self.init()
    }
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
