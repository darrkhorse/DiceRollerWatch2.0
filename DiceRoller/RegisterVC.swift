//
//  RegisterVCViewController.swift
//  DiceRoller
//
//  Created by Hinck, Johann A on 11/22/15.
//  Copyright © 2015 awesomefat. All rights reserved.
//

import UIKit
import Parse

class RegisterVC: UIViewController
{
    
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
            let av = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(av, animated: true, completion: { () -> Void in
                let delay = 2 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            })
        }
        else
        {
            
                let user = PFUser()
                user.username = self.usernameTF.text
                user.password = self.passwordTF.text
                user.email = self.emailTF.text
                // other fields can be set just like with PFObject
                
                
                user.signUpInBackgroundWithBlock
                {
                    (succeeded: Bool, error: NSError?) -> Void in
                    if let error = error
                    {
                        let errorString = error.userInfo["Error: Username or email is already taken"] as? NSString
                        // Show the errorString somewhere and let the user try again.
                        let av1 = UIAlertController(title: "Error", message: "\(errorString)", preferredStyle: UIAlertControllerStyle.Alert)
                        self.presentViewController(av1, animated: true, completion: { () -> Void in
                            let delay = 2 * Double(NSEC_PER_SEC)
                            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                                self.dismissViewControllerAnimated(true, completion: nil)
                            })
                        })
                    }
                    else
                    {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
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