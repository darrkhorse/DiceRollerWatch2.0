//
//
//  PhoneCore.swift
//  DiceRoller
//
//  Created by Michael Litman on 11/11/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit

class PhoneCore: NSObject
{
    static var theRowData : [String]!
    
    static var theUserID : String!
    
    static func showAlert(title: String, message: String, presentingViewController: UIViewController, onScreenDelay: Double)
    {
        let av = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        presentingViewController.presentViewController(av, animated: true, completion: { () -> Void in
            let delay = onScreenDelay * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                presentingViewController.dismissViewControllerAnimated(true, completion: nil)
            })
        })
        
    }
}