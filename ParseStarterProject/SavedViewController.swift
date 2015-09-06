//
//  SavedViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 8/31/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SavedViewController: UITableViewController {

    var usernames = [""]
    var userids = [""]
    
    @IBAction func logout(sender: AnyObject) {
        //--------------------------------------
        // Option 1: Show a message asking the user to log out and log back in.
        //--------------------------------------
        // If the user needs to finish what they were doing, they have the opportunity to do so.
        
        let alertView = UIAlertView(
            title: "Warning!",
            message: "Are you sure you want to log out?",
            delegate: nil,
            cancelButtonTitle: "cancel",
            otherButtonTitles: "Log Out"
        )
        alertView.show()
        
        
        //--------------------------------------
        // Option #2: Show login screen so user can re-authenticate.
        //--------------------------------------
        // You may want this if the logout button is inaccessible in the UI.
//        //
//        let presentingViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
//        let logInViewController = PFLogInViewController()
//        presentingViewController?.presentViewController(logInViewController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let users = objects {
                
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.usernames.append(user.username!)
                        self.userids.append(user.objectId!)
                        
                    }
                    
                }
                
            }
            
            println(self.usernames)
            println(self.userids)
            
            self.tableView.reloadData()
            
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = usernames[indexPath.row]
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
