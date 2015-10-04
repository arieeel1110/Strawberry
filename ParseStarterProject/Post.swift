//
//  News.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class Post: NSObject, Printable {
    
    let objectId: NSString!
    let Title: NSString
    let Image: UIImage!
    let Author: NSString
    let Text: NSString
    let Picture: UIImage!
    let Like:NSNumber!
    
    override var description: String {
        return "Title: \(Title), \n Image: \(Image), \n Author: \(Author) , \n Text: \(Text), \n Picture \(Picture), \n Like: \(Like)"
    }
    
    init(name: NSString?, image: UIImage?, author: NSString?, text: NSString, pic: UIImage?, objectId: NSString, likes:NSNumber) {
        self.Title = name ?? ""
        self.Image = image
        self.Author = author ?? ""
        self.Text = text ?? ""
        self.Picture = pic
        self.objectId = objectId
        self.Like = likes
    }
}