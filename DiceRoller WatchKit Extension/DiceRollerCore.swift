//
//  DiceRollerCore.swift
//  DiceRoller
//
//  Created by Michael Litman on 10/5/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import WatchKit

class DiceRollerCore: NSObject
{
    static var numSides = 0
    static var numDice = 1
    static var currName = ""
    static var theRolls = [Roll]()
    static var hasDice = false
    
    static func resetValues()
    {
        numSides = 0
        numDice = 1
        currName = ""
        hasDice = false
    }
}
