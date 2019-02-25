//
//  Stack.swift
//  GOT2048
//
//  Created by Divya Ravi on 02/05/19.
//  Copyright © 2019 Divya Ravi. All rights reserved.
//

class Stack {
    
    fileprivate var stackArray: [[[Box?]]] = []
    
    func clear() {
        
        stackArray.removeAll()
    }
    
    func push(_ moveState: [[Box?]]) {
        
        stackArray.append(moveState)
    }
    
    func pop() -> [[Box?]]? {
        
        if let moveState = stackArray.last {
            
            stackArray.removeLast()
            
            return moveState
            
        } else {
            
            return nil
        }
    }
}
