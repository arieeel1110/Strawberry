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
    
    @IBAction func clicked(sender: AnyObject) {
        println("cool")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //*** COLOR
                
        let gradientLayer = CAGradientLayer()
       
        var colorView = UIView(frame: CGRectMake(0, 0, 400, 230))

        gradientLayer.frame = colorView.bounds
        
        var color1 = UIColor(red: 0.1, green: 0.5, blue: 0.5, alpha: 0.7).CGColor as CGColorRef
        var color2 = UIColor(red: 0.1, green: 0.5, blue: 0.5, alpha: 0.7).CGColor as CGColorRef
        
        gradientLayer.colors = [color1, color2]
        
        gradientLayer.locations = [0.0, 1.0]
        
        colorView.layer.addSublayer(gradientLayer)
        
        self.contentView.insertSubview(colorView, belowSubview: avator)
        
        //*******
        
        username.text = PFUser.currentUser()?.username
        
        // create circuler imageview
        self.avator.layer.cornerRadius = self.avator.frame.size.width / 2;
        self.avator.clipsToBounds = true;
        
        var image: UIImage!
        
        var imageFromParse = PFUser.currentUser()?.objectForKey("profilePicture") as? PFFile
        if imageFromParse != nil {
            imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if imageData != nil {
                    image = UIImage(data: imageData!)!
                    self.avator.image = self.maskRoundedImage(image)
                } else {
                    self.avator.image = self.maskRoundedImage(self.avator.image!)
                }
            })
        }
        
//        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
//        
//        visualEffectView.frame = self.bounds
//        
//        visualEffectView.clipsToBounds = true
//        
//        var imageView = UIImageView(frame: CGRectMake(100, 100, 200, 200))
//        
//        imageView.image = image
//        self.backgroundView = UIView()
//        self.backgroundView!.addSubview(imageView)
//        self.backgroundView!.insertSubview(visualEffectView, aboveSubview: imageView)

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
