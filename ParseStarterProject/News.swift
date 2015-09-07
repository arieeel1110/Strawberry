//
//  News.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class News: NSObject, Printable {
    
    let Title: NSString
    let Image: UIImage!
    let Author: NSString
    
    override var description: String {
        return "Name: \(Title), \n Image: \(Image), \n Author: \(Author) "
    }
    
    init(name: NSString?, image: UIImage?, author: NSString?) {
        self.Title = name ?? ""
        self.Image = image
        self.Author = author ?? ""
    }
}