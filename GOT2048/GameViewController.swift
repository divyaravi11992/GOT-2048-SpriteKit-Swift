//
//  GameViewController.swift
//  GOT2048
//
//  Created by Divya Ravi on 02/05/19.
//  Copyright © 2019 Divya Ravi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            view.showsFPS = false
            view.showsNodeCount = false

            gameScene = SKScene(fileNamed: "GameScene") as! GameScene?
            gameScene?.backgroundColor = UIColor(red:0.11, green:0.32, blue:0.42, alpha:1.0)
            if gameScene != nil {
                gameScene?.scaleMode = .aspectFill
                view.presentScene(gameScene)
            }
            view.ignoresSiblingOrder = true
        }
    }
    
    @IBAction func undoButtonTapped(_ sender: AnyObject) {
        
        gameScene?.undoMove()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
