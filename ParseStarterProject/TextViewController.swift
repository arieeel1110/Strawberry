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
    
    var passedValue:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.layer.cornerRadius = 20;
        
        text.text = passedValue
        // Do any additional setup after loading the view.
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
