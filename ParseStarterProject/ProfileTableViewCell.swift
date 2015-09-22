//
//  ProfileTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/20/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileTableViewCell: UITableViewCell,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var avator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.blackColor()
        //self.avator.image = UIImage(named: "star")
        
        username.text = PFUser.currentUser()?.username
        
        var imageFromParse = PFUser.currentUser()?.objectForKey("profilePicture") as? PFFile
        if imageFromParse != nil {
            imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if imageData != nil {
                    var image: UIImage! = UIImage(data: imageData!)!
                    self.avator.image = self.maskRoundedImage(image)
                } else {
                    self.avator.image = self.maskRoundedImage(self.avator.image!)
                }
            })
        }

    }
    
    @IBAction func uploadPic(sender: AnyObject) {
        
        
//        var imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        imagePicker.allowsEditing = false
//        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//        
//        picture.image = image
//        
//        //SAVE THE PORTRAIT <<<
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    @IBAction func saveUpload(sender: AnyObject) {
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


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
