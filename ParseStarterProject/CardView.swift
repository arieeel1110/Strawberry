//
//  CardView.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import MDCSwipeToChoose

class CardView: MDCSwipeToChooseView {
    
    let ChoosePersonViewImageLabelWidth:CGFloat = 42.0;
    var person: News!
    var informationView: UIView!
    var nameLabel: UILabel!
    var authorLabel: UILabel!
    var carmeraImageLabelView:ImagelabelView!
    
    init(frame: CGRect, person: News, options: MDCSwipeToChooseViewOptions) {
        
        super.init(frame: frame, options: options)
        self.person = person
        
        if let image = self.person.Image {
            self.imageView.image = image
        }
        
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        UIViewAutoresizing.FlexibleBottomMargin
        
        self.imageView.autoresizingMask = self.autoresizingMask
        constructInformationView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func constructInformationView() -> Void{
        //var bottomHeight:CGFloat = 0
        var bottomFrame:CGRect = CGRectMake(0,
            CGRectGetHeight(self.bounds),
            CGRectGetWidth(self.bounds),
            0);
        self.informationView = UIView(frame:bottomFrame)
        self.informationView.backgroundColor = UIColor.whiteColor()
        self.informationView.clipsToBounds = true
        self.informationView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.addSubview(self.informationView)
        constructTitleLabel()
        constructAuthorLabel()
        constructCameraImageLabelView()
        //constructInterestsImageLabelView()
        //constructFriendsImageLabelView()
    }
    
    func constructTitleLabel() -> Void{
        var leftPadding:CGFloat = 10.0
        var topPadding:CGFloat = self.informationView.frame.maxY + 260
        var frame:CGRect = CGRectMake(leftPadding,
            topPadding,
            floor(CGRectGetWidth(self.informationView.frame)-12),
            CGRectGetHeight(self.informationView.frame) -  topPadding)
        self.nameLabel = UILabel(frame:frame)
        self.nameLabel.numberOfLines = 4
        
        self.nameLabel.text = "\(person.Title) "
        
        self.nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(21))
        
        self.nameLabel.layer.shadowOpacity = 0.9
        self.nameLabel.textColor = UIColor.whiteColor()
        
        insertSubview(self.nameLabel,aboveSubview:self.informationView)
    }
    
    func constructAuthorLabel() -> Void{
        var leftPadding:CGFloat = 36.0;
        var topPadding:CGFloat = self.informationView.frame.maxY - 50
        
        var frame:CGRect = CGRectMake(leftPadding,
            topPadding,
            floor(CGRectGetWidth(self.informationView.frame)/2+150.0),
            CGRectGetHeight(self.informationView.frame) + 50)
        self.authorLabel = UILabel(frame:frame)
        self.authorLabel.text = "\(person.Author)"
        
        self.authorLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(20))
        self.authorLabel.layer.shadowOpacity = 0.7
        self.authorLabel.textColor = UIColor.whiteColor()
        
        insertSubview(self.authorLabel,aboveSubview:self.informationView)
    }
    
    func constructCameraImageLabelView() -> Void{
        var image:UIImage = UIImage(named:"star")!
        
        var frame:CGRect = CGRect(x:5.0, y: 190.5,
            width: 25,
            height:25)
        self.carmeraImageLabelView = ImagelabelView(frame:frame, image:image, text:self.authorLabel.text!)
        //self.carmeraImageLabelView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin

        //self.carmeraImageLabelView = buildImageLabelViewLeftOf(CGRectGetWidth(self.informationView.bounds), image:image, text:person.NumberOfPhotos.stringValue)
        
        insertSubview(self.carmeraImageLabelView,aboveSubview:self.informationView)
    }
    
}