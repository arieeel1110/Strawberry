/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class FirstViewController: UIViewController {
    
    var button:UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.button.setTitle("Click me to start", forState: UIControlState.Normal)
        self.button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.button)
        
        self.button.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        self.button.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 100)
        self.button.autoSetDimension(ALDimension.Height, toSize: 40)
        
        self.button.addTarget(self, action: "gotoLogin", forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func gotoLogin() {
        var loginView = LoginViewController()
        
        self.presentViewController(loginView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
