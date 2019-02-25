//
//  Constants.swift
//  GOT2048
//
//  Created by Divya Ravi on 02/05/19.
//  Copyright © 2019 Divya Ravi. All rights reserved.
//

let maxX = 3
let maxY = 3

enum Direction {
    
    case Up
    case Left
    case Right
    case Down
}
enum ImageAssociation:String {
    case tyrell = "tyrell.png"
    case arryn = "arryn.jpeg"
    case martell = "martell.png"
    case tully = "tully.png"
    case baratheon = "baratheon.jpeg"
    case greyjoy = "greyjoy.png"
    case lannister = "lannister.png"
    case targarian = "targarian.jpeg"
    case stark = "stark.png"
    case throne = "throne.png"
    case knightking = "knightk.png"
    
   static func getImageValue(value: Int) -> String {
        switch value {
        case 2:
            return ImageAssociation.tyrell.rawValue
        case 4:
            return ImageAssociation.arryn.rawValue
        case 8:
            return ImageAssociation.martell.rawValue
        case 16:
            return ImageAssociation.tully.rawValue
        case 32:
            return ImageAssociation.baratheon.rawValue
        case 64:
            return ImageAssociation.greyjoy.rawValue
        case 128:
            return ImageAssociation.lannister.rawValue
        case 256:
            return ImageAssociation.stark.rawValue
        case 512:
            return ImageAssociation.targarian.rawValue
        case 1024:
            return ImageAssociation.throne.rawValue
        case 2048:
            return ImageAssociation.knightking.rawValue
        default:
            return ImageAssociation.tyrell.rawValue
        }
        
    }
}

struct EvaluationMove {
    let direction: Direction?
    let evaluationValue: Int
}
