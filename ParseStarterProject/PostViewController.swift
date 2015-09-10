//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Ariel on 9/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var upload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func uploadImgae(sender: AnyObject) {
        
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        preview.image = image
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func submitButton(sender: AnyObject) {
        
        var imageText = text.text
        
        if preview.image == nil {
            //image is not included alert user
            println("Image not uploaded")
        }else {
            
            var posts = PFObject(className: "Post")
            posts["imageText"] = imageText
            posts["uploader"] = PFUser.currentUser()
            posts.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    /**success saving, Now save image.***/
                    
                    //create an image data
                    var imageData = UIImagePNGRepresentation(self.preview.image)
                    //create a parse file to store in cloud
                    var parseImageFile = PFFile(name: "uploaded_image.png", data: imageData)
                    posts["imageFile"] = parseImageFile
                    posts.saveInBackgroundWithBlock({
                        (success: Bool, error: NSError?) -> Void in
                        
                        if error == nil {
                            //take user home
                            println("data uploaded")
                            //self.performSegueWithIdentifier("goHomeFromUpload", sender: self)
                            
                            let alertView = UIAlertView(
                                title: "Congradulations!",
                                message: "Uploaded succesfully",
                                delegate: nil,
                                cancelButtonTitle: "back to Post page",
                                otherButtonTitles: "Go to Home"
                            )
                            alertView.show()
                            
                        }else {
                            
                            println(error)
                        }
                        
                        
                    })
                    
                    
                }else {
                    println(error)
                    
                }
                
            })
            
            
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
