//
//  pickerExampleIC.swift
//  DiceRoller
//
//  Created by Michael Litman on 9/30/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import WatchKit
import Foundation


class pickerExampleIC: WKInterfaceController
{
    let alert = WKAlertAction(title: "Ok", style: WKAlertActionStyle.Cancel, handler: { () -> Void in })
    
    let sides = [4,6,8,10,12,20,100];
    
    @IBOutlet var thePicker: WKInterfacePicker!
    var currSelectedIndex = 0
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        print("******** \(context)");
        
        
        var thePickerItems = [WKPickerItem]()
        let labelNames = ["d4","d6","d8","d10","d12","d20","d100"]
        for(var i = 0; i < labelNames.count; i++)
        {
            thePickerItems.append(WKPickerItem())
            thePickerItems[i].title = labelNames[i]
            thePickerItems[i].contentImage = WKImage(imageName: labelNames[i] + ".jpeg")
            thePickerItems[i].caption = labelNames[i]
        }
        
        self.thePicker.setItems(thePickerItems)
        // Configure interface objects here.
    }

    @IBAction func whichOneButtonPressed()
    {
        //self.presentAlertControllerWithTitle("The Roll", message: "\(rand()%Int32(sides[self.currSelectedIndex]) + 1)", preferredStyle: WKAlertControllerStyle.Alert, actions: [alert])
        //self.dismissController()
        //self.popToRootController()
        DiceRollerCore.numDice = self.currSelectedIndex
        self.popToRootController()
        
    }
    
    @IBAction func pickerWasClicked(value: Int)
    {
        self.currSelectedIndex = value
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
