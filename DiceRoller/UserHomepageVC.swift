//
//  UserHomepageVC.swift
//  DiceRoller
//
//  Created by Michael Litman on 11/23/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import WatchConnectivity
import Parse

class UserHomepageVC: UIViewController
{
    
    @IBOutlet weak var userID: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        userID.text = PhoneCore.theUserID!
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}