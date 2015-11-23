//
//  MainScreenIC.swift
//  DiceRoller
//
//  Created by Michael Litman on 10/7/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class MainScreenIC: WKInterfaceController, WCSessionDelegate
{
    var session : WCSession!
    
    var count = 1
    
    @IBOutlet var theTable: WKInterfaceTable!
    
    @IBOutlet var theModeLabel: WKInterfaceLabel!
    
    var currMode = "Roll"
    static var currSelectedIndex = -1
    let rollAlert = WKAlertAction(title: "Ok", style: WKAlertActionStyle.Cancel, handler: { () -> Void in })
    let deleteAlertCancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Cancel, handler: { () -> Void in print("Canceled Delete")})
    
    let deleteAlertConfirm = WKAlertAction(title: "Confirm", style: WKAlertActionStyle.Cancel, handler: { () -> Void in
        
        //Delete the current row from theRolls
        DiceRollerCore.theRolls.removeAtIndex(MainScreenIC.currSelectedIndex)
        //updateUserDefaults()
        //generateTable()
    })
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        
        if WCSession.isSupported() {
            self.session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        
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
        MainScreenIC.currSelectedIndex = rowIndex
        
        if(currMode == "Roll")
        {
            let  rollString = DiceRollerCore.theRolls[rowIndex].roll()
            self.presentAlertControllerWithTitle("The Roll", message: rollString, preferredStyle: WKAlertControllerStyle.Alert, actions: [rollAlert])
            
            session.sendMessage(["aRoll": rollString], replyHandler: nil, errorHandler: nil)
            
        }
        else if(currMode == "Edit")
        {
            self.presentAlertControllerWithTitle("The Roll", message: "Edit", preferredStyle: WKAlertControllerStyle.Alert, actions: [rollAlert])
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
            
        }
        //update the user defaults
        self.updateUserDefaults()
        
        //we need to rebuild our table
        self.generateTable()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject?
    {
        print("In segue")
        //let applicationData = ["counterValue":"5", "blah":"7"]
        
        /*
        session.sendMessage(applicationData, replyHandler: {(theReply: [String : AnyObject]) -> Void in
        print("received reply on watch")
        }, errorHandler: {(error ) -> Void in
        print("Problem sending: \(error)")
        })
        */
        
        /*
        
        try! session.updateApplicationContext(["blah\(self.count)":"\(self.count)"])
        self.count++;
        //try! session.updateApplicationContext(["blah":"11"])
        */
        return nil
    }
    
}
