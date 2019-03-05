//
//  GameScene.swift
//  GOT2048
//
//  Created by Divya Ravi on 02/05/19.
//  Copyright © 2019 Divya Ravi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, GridDelegate {

    let kBlockSize: CGFloat = 150.0
    let kNumberOfRows: Int = 4
    let kNumberOfColumns: Int = 4
    let kAnimationDuration = 0.3
    
    var grid: Grid?
    var gridView: GridView?
    
    var randomBoxGenerator: RandomBoxGenerator?
    
    var boxNodeArray: [[BoxNode?]] = [[BoxNode?]](repeating: [BoxNode?](repeating: nil, count: 4), count: 4)
    
    @objc func takeTurn(sender:UISwipeGestureRecognizer) {
        
        var direction: Direction
        
        if sender.direction == UISwipeGestureRecognizer.Direction.left {
            
            direction = Direction.Left
            
        } else if sender.direction == UISwipeGestureRecognizer.Direction.right {
            
            direction = Direction.Right
            
        } else if sender.direction == UISwipeGestureRecognizer.Direction.up {
            
            direction = Direction.Up
            
        } else {
            
            direction = Direction.Down
        }
        
        let _ = grid?.takeTurn(direction: direction)
    }
    
    func setupSwipeGestures(to view: SKView) {
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.takeTurn(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.takeTurn(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.takeTurn(sender:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.takeTurn(sender:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    override func didMove(to view: SKView) {
        
        setupSwipeGestures(to: view)
        
        gridView = GridView(blockSize: kBlockSize, rows: kNumberOfRows, cols: kNumberOfColumns)
        gridView?.position = CGPoint(x: 0.0, y: 0.0)
        addChild(gridView!)
        
        randomBoxGenerator = RandomBoxGenerator(isRandom: true, gridDelegate: self)
        
        grid = Grid()
        grid?.randomBoxGenerator = randomBoxGenerator
        grid?.setup()
    }
    
    func didCalculateMoveDirection(direction: Direction) {
        
        grid?.randomBoxGenerator = randomBoxGenerator
        
    }

    func placeBox(box: Box) {
        
        let boxNode: BoxNode = BoxNode(blockSize: 0)
        boxNode.position = gridView!.gridPosition(row: box.y, col: box.x)
        
        gridView?.addChild(boxNode)
        
        boxNodeArray[box.x][box.y] = boxNode
        
        DispatchQueue.main.asyncAfter(deadline: .now() + kAnimationDuration) {
            
            boxNode.run(SKAction.resize(toWidth: self.kBlockSize, height: self.kBlockSize, duration: self.kAnimationDuration), completion: {
                
                boxNode.texture = SKTexture.init(imageNamed: ImageAssociation.getImageValue(value: box.number))
            })
        }
    }
    
    func move(box: Box, to x: Int, to y: Int) {
        
        let boxNode: BoxNode = boxNodeArray[box.x][box.y]!
        
        boxNodeArray[box.x][box.y] = nil
        
        boxNodeArray[x][y] = boxNode
        
        movementAnimation(boxNode: boxNode, to: x, to: y, completionHandler: nil)
    }
    
    func merge(firstBox: Box, secondBox: Box) {
        
        let firstBoxNode: BoxNode = boxNodeArray[firstBox.x][firstBox.y]!
        
        boxNodeArray[firstBox.x][firstBox.y] = nil
        
        let secondBoxNode: BoxNode = boxNodeArray[secondBox.x][secondBox.y]!
        
        
        movementAnimation(boxNode: firstBoxNode, to: secondBox.x, to: secondBox.y, completionHandler: {
            
            firstBoxNode.run(SKAction.fadeOut(withDuration: self.kAnimationDuration), completion: {
            
                firstBoxNode.removeFromParent()
                
                secondBoxNode.texture = SKTexture.init(imageNamed: ImageAssociation.getImageValue(value: secondBox.number))
                secondBoxNode.physicsBody?.applyImpulse(CGVector.init(dx: 1.0, dy: 1.0))
            })
        })
    }
    
    func movementAnimation(boxNode: BoxNode, to x: Int, to y: Int, completionHandler: (() -> Void)?) {
        
        let movementAction: SKAction = SKAction.move(to: gridView!.gridPosition(row: y, col: x), duration: kAnimationDuration)
        
        if let completionHandler = completionHandler {
            
            boxNode.run(movementAction, completion: completionHandler)
            
        } else {
            
            boxNode.run(movementAction)
        }
    }
    
    func undoMove() {
        
        grid?.undoMove()
    }
    
    func didUndoMove() {
        
        gridView?.removeFromParent()
        
        gridView = GridView(blockSize: kBlockSize, rows: kNumberOfRows, cols: kNumberOfColumns)
        gridView?.position = CGPoint(x: 0.0, y: 0.0)
        addChild(gridView!)
    }
    
    func gameOver() {
        
        gridView?.removeFromParent()
        
        gridView = GridView(blockSize: kBlockSize, rows: kNumberOfRows, cols: kNumberOfColumns)
        gridView?.position = CGPoint(x: 0.0, y: 0.0)
        addChild(gridView!)
        
        grid = Grid()
        grid?.randomBoxGenerator = randomBoxGenerator
        grid?.setup()
    }
    
    func selectQueueAndRun(_ queue: DispatchQueue, action: @escaping () -> ()) {
        queue.async {
            action()
        }
    }
}
