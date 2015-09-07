//
//  ImageLabelVIew.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MDCSwipeToChoose


class ImagelabelView: UIView{
    var imageView: UIImageView!
    var label: UILabel!
    
    convenience init(){
        self.init()
        imageView = UIImageView()
        label = UILabel()
    }
    
    init(frame: CGRect, image: UIImage, text: String) {
        
        super.init(frame: frame)
        constructImageView(image,frame:frame)
        //constructLabel(text)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func constructImageView(image:UIImage,frame:CGRect) -> Void{
        
        let topPadding:CGFloat = 10.0
        
        //let framex = CGRectMake(floor((CGRectGetWidth(self.bounds) - image.size.width)/2),
            //topPadding,
            //300,
           // 400)
        imageView = UIImageView(frame: frame)
        imageView.image = image
        addSubview(self.imageView)
    }
    
//    func constructLabel(text:String) -> Void{
//        var height:CGFloat = 18.0
//        let frame2 = CGRectMake(0,
//            CGRectGetMaxY(self.imageView.frame),
//            CGRectGetWidth(self.bounds),
//            height);
//        self.label = UILabel(frame: frame2)
//        label.text = text
//        addSubview(label)
//    }
}