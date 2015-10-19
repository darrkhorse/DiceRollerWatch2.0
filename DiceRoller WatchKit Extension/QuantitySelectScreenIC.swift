//
//  QuantitySelectScreenIC.swift
//  DiceRoller
//
//  Created by Michael Litman on 10/7/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import WatchKit
import Foundation


class QuantitySelectScreenIC: WKInterfaceController
{
    @IBOutlet var thePicker: WKInterfacePicker!

    @IBAction func pickerDidChange(value: Int)
    {
        DiceRollerCore.numDice = value + 1
    }
    
    @IBAction func selectNameButtonPressed()
    {
        let suggestions = ["attack","initiative","damage"]
        self.presentTextInputControllerWithSuggestions(suggestions, allowedInputMode: WKTextInputMode.Plain) { (vals) -> Void in
            //["attack"] : [AnyObject]?
            DiceRollerCore.currName = vals![0] as! String
            DiceRollerCore.hasDice = true
            self.popToRootController()
        }

       
    }
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)        
        var thePickerItems = [WKPickerItem]()
        for(var i = 1; i <= 100; i++)
        {
            thePickerItems.append(WKPickerItem())
            thePickerItems[i-1].title = "\(i)"
        }
        
        self.thePicker.setItems(thePickerItems)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
