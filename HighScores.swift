//
//  HighScores.swift
//  Kids Joy Center
//
//  Created by Artis, Justin (CONT) on 3/27/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import Foundation


class HighScore: NSObject, NSCoding {
    
    var game = " "
    var score = 0
    
    init(gameScore: Int){
        score = gameScore
    }
    
    //used when saved (encoded) to user defaults
    func encode(with aCoder: NSCoder) {
        aCoder.encode(score, forKey: "GameScore")
    }
    
    // used when read (decoded) from user defaults
    required init?(coder aDecoder: NSCoder) {
        score = aDecoder.decodeObject(forKey: "GameScore") as! Int
    }
    
}
