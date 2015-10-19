//
//  MainScreenIC.swift
//  DiceRoller
//
//  Created by Michael Litman on 10/7/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import WatchKit
import Foundation


class MainScreenIC: WKInterfaceController
{

    @IBOutlet var theTable: WKInterfaceTable!
    
    @IBOutlet var theModeLabel: WKInterfaceLabel!
    
    var currMode = "Roll"
    let rollAlert = WKAlertAction(title: "Ok", style: WKAlertActionStyle.Cancel, handler: { () -> Void in })
    let deleteAlertCancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Cancel, handler: { () -> Void in print("Canceled Delete")})
    let deleteAlertConfirm = WKAlertAction(title: "Confirm", style: WKAlertActionStyle.Cancel, handler: { () -> Void in
    
        //Delete the current row from theRolls
        //DiceRollerCore.theRolls.removeAtIndex(???)
        //updateUserDefaults()
        //generateTable()
    })
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let theDiceStrings = prefs.valueForKey("theDiceStrings");
        
        if(theDiceStrings != nil)
        {
            let vals = theDiceStrings as! NSArray
            for s in vals
            {
                DiceRollerCore.theRolls.append(Roll(rollString: s as! String))
            }
            self.generateTable()
        }
    }

    //Context Menu Actions
    func updateModeLabel()
    {
        self.theModeLabel.setText("Mode: \(self.currMode)")
    }
    
    @IBAction func rollContextButtonPressed()
    {
        self.currMode = "Roll"
        self.updateModeLabel()
    }
    
    @IBAction func editContextButtonPressed()
    {
        self.currMode = "Edit"
        self.updateModeLabel()
    }
    
    @IBAction func deleteContextButtonPressed()
    {
        self.currMode = "Delete"
        self.updateModeLabel()
    }
    
    func generateTable()
    {
        self.theTable.setNumberOfRows(DiceRollerCore.theRolls.count, withRowType: "cell")
        
        for(var i = 0; i < DiceRollerCore.theRolls.count; i++)
        {
            let currRow = self.theTable.rowControllerAtIndex(i) as! rollRow
            currRow.qtyLabel.setText("\(DiceRollerCore.theRolls[i].qty)")
            currRow.sidesLabel.setText("D\(DiceRollerCore.theRolls[i].numSides)")
            currRow.nameLabel.setText("Name: \(DiceRollerCore.theRolls[i].name)")
        }

    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int)
    {
        if(currMode == "Roll")
        {
            self.presentAlertControllerWithTitle("The Roll", message: DiceRollerCore.theRolls[rowIndex].roll(), preferredStyle: WKAlertControllerStyle.Alert, actions: [rollAlert])

        }
        else if(currMode == "Edit")
        {
            var selection: Int
            selection = rowIndex
            let suggestions = ["attack","initiative","damage"]
            self.presentTextInputControllerWithSuggestions(suggestions, allowedInputMode: WKTextInputMode.Plain) { (vals) -> Void in
                //["attack"] : [AnyObject]?
                
                DiceRollerCore.theRolls[selection].name = vals![0] as! String
               
                
                self.updateUserDefaults()
                self.generateTable()
                self.popToRootController()
            }
        }
        else if(currMode == "Delete")
        {
            self.presentAlertControllerWithTitle("** Delete **", message: "Confirm Delete?", preferredStyle: WKAlertControllerStyle.Alert, actions: [deleteAlertCancel, deleteAlertConfirm])
        }
    }
    
    func updateUserDefaults()
    {
        var theDiceStrings = [String]()
        for(var i = 0; i < DiceRollerCore.theRolls.count; i++)
        {
            theDiceStrings.append(DiceRollerCore.theRolls[i].toString())
        }
        
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setObject(theDiceStrings, forKey: "theDiceStrings");
    }
    
    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(DiceRollerCore.hasDice)
        {
            //we need to add the new Roll to our array of Rolls
            DiceRollerCore.theRolls.append(Roll(qty: DiceRollerCore.numDice, numSides: DiceRollerCore.numSides, name: DiceRollerCore.currName))
            DiceRollerCore.resetValues()
            
            //update the user defaults
            self.updateUserDefaults()
            
            //we need to rebuild our table
            self.generateTable()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
