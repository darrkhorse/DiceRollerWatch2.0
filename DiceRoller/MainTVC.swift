//
//  MainTVC.swift
//  DiceRoller
//
//  Created by Michael Litman on 11/11/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import WatchConnectivity
import Parse

class MainTVC: UIViewController, WCSessionDelegate, UITableViewDataSource, UITableViewDelegate
{
    let defaults = NSUserDefaults.standardUserDefaults()
    var session : WCSession!
    @IBOutlet weak var tv: UITableView!
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject])
    {
        PhoneCore.theRowData.append(message["aRoll"] as! String)
        self.defaults.setObject(PhoneCore.theRowData, forKey: "theRolls")
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tv.reloadData()
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject["name"] = "mike"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
        var theRolls = self.defaults.objectForKey("theRolls")
        if(theRolls == nil)
        {
            theRolls = [String]()
            self.defaults.setObject(theRolls, forKey: "theRolls")
        }
        PhoneCore.theRowData = theRolls as! [String]
        
        if WCSession.isSupported() {
            self.session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return PhoneCore.theRowData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        print("getting cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! rollDetailCell
        
        // Configure the cell...
        let theParts = PhoneCore.theRowData[indexPath.row].componentsSeparatedByString("->")
        cell.rollTotalLabel.text = theParts[1]
        let rtvc = storyboard?.instantiateViewControllerWithIdentifier("RollsTVC") as! RollsTVC
        cell.rtvc = rtvc
        cell.rollDetailsTV.dataSource = rtvc
        cell.rollDetailsTV.delegate = rtvc
        print(theParts[0])
        var rollString = theParts[0].substringFromIndex(theParts[0].startIndex.advancedBy(1))
        rollString = rollString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        rollString = rollString.substringToIndex(rollString.endIndex.predecessor())
        rtvc.theRolls = rollString.componentsSeparatedByString(" ")
        
        //cell.detailTextLabel?.text = theParts[0]
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}