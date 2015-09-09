//
//  LoginViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 8/15/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var subButton: UIButton!
    
    @IBOutlet var indicationText: UILabel!
    
    @IBOutlet var mainButton: UIButton!
    
    
    var signupActivie = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func auth(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username password")
            
        } else {
            authUser(username.text, password: password.text);
        }
        
    }
    
    @IBAction func authOptons(sender: AnyObject) {
        
        if signupActivie == true {
            
            mainButton.setTitle("LOG IN", forState: UIControlState.Normal)
            
            indicationText.text = "Not registered?"
            
            subButton.setTitle("SIGN UP", forState: UIControlState.Normal)
            
            signupActivie = false
            
        } else {
            
            mainButton.setTitle("SIGN UP", forState: UIControlState.Normal)
            
            indicationText.text = "Already registered?"
            
            subButton.setTitle("LOG IN", forState: UIControlState.Normal)
            
            signupActivie = true
            
        }
        
    }
    
    func authUser(username: String, password: String) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        var errorMessage = "Please try again later"
        
        if signupActivie == true {
            var user = PFUser()
            user.username = username
            user.password = password
            
            
            user.signUpInBackgroundWithBlock ({ (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    // Sign up successfull
                    self.performSegueWithIdentifier("login", sender: self)
                    
                } else {
                    
                    if let errorString = error!.userInfo?["error"] as?String {
                        
                        errorMessage = errorString
                        
                    }
                    
                    self.displayAlert("Failed Signup", message: errorMessage)
                    
                }
            })
            
        } else {
            
            PFUser.logInWithUsernameInBackground(username, password:password) {
                (user: PFUser?, error: NSError?) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if user != nil {
                    // Do stuff after successful login.
                    self.performSegueWithIdentifier("login", sender: self)

                } else {
                    
                    if let errorString = error!.userInfo?["error"] as?String {
                        
                        errorMessage = errorString
                        
                    }
                    
                    self.displayAlert("Failed Login", message: errorMessage)
                    
                }
            }
        }
        
    }
    
    func displayAlert(title: String, message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
