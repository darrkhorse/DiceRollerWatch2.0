//
//  LoginVC.swift
//  DiceRoller
//
//  Created by Michael Litman on 11/20/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController
{
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.usernameTF.becomeFirstResponder()
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject)
    {
        var message = ""
        
        if(self.usernameTF.text!.characters.count == 0)
        {
            message = "You must enter a username"
        }
        else if(self.passwordTF.text!.characters.count == 0)
        {
            message = "You must enter a password"
        }
        
        if(message.characters.count != 0)
        {
            //there was a problem
            PhoneCore.showAlert("Login Error", message: message, presentingViewController: self, onScreenDelay: 2)
        }
        else
        {
            PFUser.logInWithUsernameInBackground(self.usernameTF.text!, password:self.passwordTF.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil
                {
                    // Do stuff after successful login.
                    PhoneCore.theUserID = "The user id is: \(user!.objectId!)"
                    let uhvc = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomepageVC") as! UserHomepageVC
                    self.presentViewController(uhvc, animated: true, completion: nil)
                }
                else
                {
                    // The login failed. Check error to see why.
                    PhoneCore.showAlert("Login Error", message: message, presentingViewController: self, onScreenDelay: 2)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
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
