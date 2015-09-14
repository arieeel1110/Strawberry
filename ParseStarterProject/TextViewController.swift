//
//  TextViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Ariel on 9/11/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit


class TextViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var textTitle: UITextView!
    
    var passedText:String!
    var passedAuthor:String!
    var passedPic:UIImage!
    var passedTitle:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.layer.cornerRadius = 20;
        
        textTitle.text = passedTitle
        text.text = passedText
        picture.image = maskRoundedImage(passedPic)
        author.text = passedAuthor
        
        
        // Do any additional setup after loading the view.
    }
    
    func maskRoundedImage(image: UIImage) -> UIImage {
        
        let imageView = UIImageView(image: image)
        
        
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(100)
        
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
