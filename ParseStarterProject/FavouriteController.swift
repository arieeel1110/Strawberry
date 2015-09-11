//
//  FavouriteController.swift
//  ParseStarterProject-Swift
//
//  Created by Ariel on 9/9/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class FavouriteController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = PFUser.currentUser()?.username
        
        var imageFromParse = PFUser.currentUser()?.objectForKey("profilePicture") as? PFFile
        imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            if imageData != nil {
                var image: UIImage! = UIImage(data: imageData!)!
                self.picture.image = image
            } else {
                self.picture.image = self.maskRoundedImage(self.picture.image!)
            }
        })
        
    }

    @IBAction func uploadPic(sender: AnyObject) {
        
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        picture.image = image
                
        //SAVE THE PORTRAIT <<<
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func uploadProfilePicture(sender: UIButton) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        if picture.image == nil {
            //image is not included alert user
            println("Image not uploaded")
        }else {
            
            // get class model
            var user = PFUser.currentUser()!
            
            //create an image data
            var imageData = UIImagePNGRepresentation(self.picture.image)
            //create a parse file to store in cloud
            var parseImageFile = PFFile(name: "uploaded_image.png", data: imageData)
            
            user["profilePicture"] = parseImageFile
            
            user.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    /**success saving, Now save image.***/
                    
                }else {
                    println(error)
                    
                }
                
            })
            
        }
        
    }
    
    func maskRoundedImage(image: UIImage) -> UIImage {
        
        let imageView = UIImageView(image: image)
 
        
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(25)
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext())
        var roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage
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
