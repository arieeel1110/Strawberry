//
//  SavedViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 8/31/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SavedViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var usernames = [""]
    var userids = [""]
    
    var favorPost = [PFObject]()
    
    var valueToPass:String!
    var picToPass:UIImage!
    var authorToPass:String!
    var titleToPass:String!
    
    var profileCell:ProfileTableViewCell!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func logout(sender: AnyObject) {
        resetLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //*** delete lines
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // get data from like relationship
        refreshData()
    }
    
    override func viewDidAppear(animated: Bool) {
<<<<<<< HEAD
        
        println("reload!!!!!!!!!!!!!!!!!!!!!")
        self.tableView.reloadData()
        
=======
        refreshData()
>>>>>>> a2d14f16bf94cb0d3da8b0a51e35d798f9061519
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
        // Return the number of rows in the section.
        return favorPost.count+2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (indexPath.row==0){
            return 230
        }
        else if (indexPath.row==1){
            return 36
        }
        else{
            return 70
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
<<<<<<< HEAD

        if  (indexPath.row == 0) {

           profileCell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileTableViewCell

=======
        if  (indexPath.row == 0) { // get current user data
            profileCell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileTableViewCell
>>>>>>> a2d14f16bf94cb0d3da8b0a51e35d798f9061519
            return profileCell
        }
        else if (indexPath.row == 1) {  // set header cell
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "favouriteCell")
            
            cell.textLabel?.text = "MY FAVOURITES"
            cell.imageView?.image = UIImage(named:"favourite")
            let size = CGSizeMake(28, 28)
            cell.imageView?.image! = imageResize(image:cell.imageView!.image!,sizeChange: size)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(13))
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    
            return cell
        }
        else {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "favouriteCell")
            
            cell.textLabel?.numberOfLines = 3
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(13))
            cell.textLabel?.text = (favorPost[indexPath.row-2]).valueForKey("title") as? String
            
            //author
            let author = (favorPost[indexPath.row-2]).valueForKey("uploader") as! PFUser
            author.fetchIfNeeded()
            
            //authorName
            var authorName = author.username as String!
            
            cell.detailTextLabel?.font = UIFont(name: "Avenir", size: CGFloat(12))
            cell.detailTextLabel?.text = "@\(authorName)"
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            
            var userImageFile = (favorPost[indexPath.row-2]).valueForKey("imageFile") as? PFFile
            var image = UIImage(data: userImageFile!.getData()!)
            cell.imageView?.image = maskRoundedImage(image!)
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var query = PFQuery(className:"Post")
            var currentObject = self.favorPost[indexPath!.row - 2] as PFObject
        
            // remove from relationship with current post
            var user = PFUser.currentUser()
            var relation = user!.relationForKey("likes")
            relation.removeObject(currentObject)
            user!.saveInBackground()
            
            self.favorPost.removeAtIndex(indexPath!.row-2)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        if indexPath.row > 1 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let row = indexPath.row
            var currentPerson = self.favorPost[row-2] as PFObject
            
            self.valueToPass = currentPerson.valueForKey("imageText") as! String
            var author =  currentPerson.valueForKey("uploader") as! PFUser
            self.authorToPass = author.username
            self.titleToPass = currentPerson.valueForKey("title") as! String
            var picFile = author.objectForKey("profilePicture") as? PFFile
            self.picToPass = UIImage(data: picFile!.getData()!)
            self.performSegueWithIdentifier("SaveToText", sender: self)
        }
        else if indexPath == 0 {
            self.performSegueWithIdentifier("SaveToUpload", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "SaveToText") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! TextViewController
            // your new view controller should have property that will store passed value
            viewController.passedText = valueToPass
            viewController.passedPic = picToPass
            viewController.passedAuthor = authorToPass
            viewController.passedTitle = titleToPass
        }
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // helper method
    
    // resize image
    func imageResize (#image:UIImage, sizeChange:CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    // create rounded image
    func maskRoundedImage(image: UIImage) -> UIImage {
        let imageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        imageView.image = image
        var layer: CALayer = CALayer()
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(20)
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext())
        var roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
    
    // refresh data from parse
    func refreshData() {
        var user = PFUser.currentUser()
        var relation = user!.relationForKey("likes")
        
        relation.query()?.findObjectsInBackgroundWithBlock({(objects:[AnyObject]?, error:NSError?) -> Void in
            if let error = error {
                // There was an error
            } else {
                // objects has all the Posts the current user liked.
                self.favorPost = objects as! [PFObject]
                self.tableView.reloadData()
            }
        })
    }
    
    
    // log out
    func resetLoginView(){
        PFUser.logOut()
        if (PFUser.currentUser() == nil) {
            self.navigationController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
