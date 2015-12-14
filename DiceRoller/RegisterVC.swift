//
//  RegisterVC.swift
//  DiceRoller
//
//  Created by Michael Litman on 11/20/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import Parse

class RegisterVC: UIViewController
{
    
    @IBOutlet weak var theSpinner: UIActivityIndicatorView!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.usernameTF.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonPressed(sender: AnyObject)
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
        else if(self.confirmPasswordTF.text!.characters.count == 0)
        {
            message = "You must confirm the password"
        }
        else if(self.emailTF.text!.characters.count == 0)
        {
            message = "You must enter an email address"
        }
        else if(self.passwordTF.text! != self.confirmPasswordTF.text!)
        {
            message = "Passwords Did Not Match!"
        }
        
        if(message.characters.count != 0)
        {
            //there was a problem
            PhoneCore.showAlert("Register Error", message: message, presentingViewController: self, onScreenDelay: 2)
        }
        else
        {
            //register the user
            let user = PFUser()
            user.username = self.usernameTF.text
            user.password = self.passwordTF.text
            user.email = self.emailTF.text
            
            //non blocking asyc call
            self.theSpinner.startAnimating()
            
            user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if(success)
                {
                    //user is registered, do what now?
                    self.theSpinner.stopAnimating()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else
                {
                    //there was a problem
                    print(error?.userInfo["error"])
                }
            })
            
            
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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