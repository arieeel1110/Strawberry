//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Ariel on 9/10/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import IQDropDownTextField

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate{

    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var postTitle: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var upload: UIButton!
    
    @IBOutlet weak var occupationTextField: IQDropDownTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 0.97, green: 0.97,  blue: 0.97, alpha:1)
        
        loading.hidden = true
        
        textView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        textView.textColor = UIColor.lightGrayColor()
        
        occupationTextField.isOptionalDropDown = false
        occupationTextField.itemList = ["weight", "muscle", "meal", "idol"]
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Share your tips or story"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBAction func uploadImage(sender: AnyObject) {
        
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
        
        loading.hidden = false
        loading.startAnimating()
        
        if preview.image == nil {
            //image is not included alert user
            println("Image not uploaded")
        }else {
            
            // get class model
            var posts = PFObject(className: "Post")
    
            //create an image data
            var imageData = UIImagePNGRepresentation(self.preview.image)
            //create a parse file to store in cloud
            var parseImageFile = PFFile(name: "uploaded_image.png", data: imageData)
            
            posts["imageText"] = textView.text
            posts["uploader"] = PFUser.currentUser()
            posts["title"] = postTitle.text
            posts["category"] = occupationTextField.text
            posts["imageFile"] = parseImageFile
            posts.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                
                if error == nil {
                    /**success saving, Now save image.***/
                    
                    self.loading.stopAnimating()
                    self.loading.hidden = true
                    
                    let alertView = UIAlertView(
                        title: "Congradulations!",
                        message: "Uploaded succesfully",
                        delegate: nil,
                        cancelButtonTitle: "back to Post page",
                        otherButtonTitles: "Go to Home"
                    )
                    alertView.show()
                    
                    self.performSegueWithIdentifier("PostAlertToWorld", sender: self)
                    
                }else {
                    println(error)
                    
                }
                
            })
            
        }
        
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
        case 0:
            self.performSegueWithIdentifier("PostAlertToWorld", sender: self)
            break;
        case 1:
            self.performSegueWithIdentifier("PostAlertToHome", sender: self)
            break;
        default:
            self.performSegueWithIdentifier("PostAlertToHome", sender: self)
            break;
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
