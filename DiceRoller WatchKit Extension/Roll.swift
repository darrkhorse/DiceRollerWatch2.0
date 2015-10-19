//
//  Roll.swift
//  DiceRoller
//
//  Created by Michael Litman on 10/9/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import WatchKit

class Roll: NSObject
{
    var numSides: Int
    var qty: Int
    var name: String
    
    init(qty: Int, numSides: Int, name: String)
    {
        self.qty = qty
        self.numSides = numSides
        self.name = name
    }
    
    init(rollString: String)
    {
        let parts = rollString.componentsSeparatedByString(":")
        self.qty = Int(parts[0])!
        self.numSides = Int(parts[1])!
        if(parts.count == 3)
        {
            self.name = parts[2]
        }
        else
        {
            self.name = "N/A"
        }
        
    }
    
    func toString() -> String
    {
        return "\(qty):\(numSides):\(name)"
    }
    
    func roll() -> String
    {
        var answer = "["
        var total = 0
        for(var i = 0; i < self.qty; i++)
        {
            let currRoll = Int(rand()) % self.numSides + 1
            answer = "\(answer)\(currRoll) "
            total += currRoll
        }
        answer = "\(answer)] -> \(total)"
        return answer
    }
}
