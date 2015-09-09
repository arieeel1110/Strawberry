//
//  CardViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

var favorTitle = [String]()
var favorImage = [UIImage]()

class CardViewController: UIViewController,MDCSwipeToChooseDelegate {
    
    var people:[News] = []
    let ChoosePersonButtonHorizontalPadding:CGFloat = 80.0
    let ChoosePersonButtonVerticalPadding:CGFloat = 20.0
    var currentPerson:News!
    var frontCardView:CardView!
    var backCardView:CardView!
    
    var menuContainer: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.people = defaultPeople()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.people = defaultPeople()
        // Here you can init your properties
    }
    
    convenience init(){
        self.init()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Display the first ChoosePersonView in front. Users can swipe to indicate
        // whether they like or dislike the person displayed.
        self.setFontCard(self.popPersonViewWithFrame(frontCardViewFrame())!)
        self.view.addSubview(self.frontCardView)
        
        // Display the second ChoosePersonView in back. This view controller uses
        // the MDCSwipeToChooseDelegate protocol methods to update the front and
        // back views after each user swipe.
        self.backCardView = self.popPersonViewWithFrame(backCardViewFrame())!
        self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
        
        addMenuContainer()
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        if sender.tag == 0 {
            println("Button tapped")
        }
    }
    
    @IBAction func Category(sender: AnyObject) {
        
        menuContainer.hidden = !menuContainer.hidden
    }
    
    
    func addMenuContainer(){
        
        var frame:CGRect = CGRectMake(70,
            170, view.bounds.width-120,view.bounds.height-320)
        
        
        self.menuContainer=UIView(frame: frame)
        self.menuContainer.hidden = true
        self.menuContainer.layer.cornerRadius = 25
        self.menuContainer.backgroundColor=UIColor.blackColor().colorWithAlphaComponent(0.1)
        
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        
        visualEffectView.frame = menuContainer.bounds
        
        visualEffectView.layer.cornerRadius = 15
        visualEffectView.clipsToBounds = true
        
        menuContainer.addSubview(visualEffectView)
        
        addButton()
        
        self.view.insertSubview(self.menuContainer,aboveSubview: self.frontCardView )
        
    }
    
    func addButton(){
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var leftpadding = menuContainer.bounds.origin.x+30
        var toppadding = menuContainer.bounds.origin.y+40
        
        button.frame = CGRectMake(leftpadding, toppadding, 50, 50)
        
        let image = UIImage(named: "star") as UIImage?
        button.setImage(image, forState: .Normal)
        //button.backgroundColor = UIColor.blackColor()
        //button.setTitle("Test Button", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.tag=0
        
        menuContainer.addSubview(button)
        
        //*************
        
        let button2   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var leftpadding2 = menuContainer.bounds.origin.x+110
        var toppadding2 = menuContainer.bounds.origin.y+40
        
        button2.frame = CGRectMake(leftpadding2, toppadding2, 50, 50)
        
        let image2 = UIImage(named: "star") as UIImage?
        button2.setImage(image2, forState: .Normal)
        
        button2.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.tag=1
        
        menuContainer.addSubview(button2)
        
    }
    
    
    func suportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.Portrait
    }
    
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(view: UIView) -> Void{
        
        println("You couldn't decide on \(self.currentPerson.Title)");
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        
        // MDCSwipeToChooseView shows "NOPE" on swipes to the left,
        // and "LIKED" on swipes to the right.
        if(wasChosenWithDirection == MDCSwipeDirection.Left){
            println("You noped: \(self.currentPerson.Title)")
        }
        else{
            
            println("You liked: \(self.currentPerson.Title)")
            
            favorTitle.append("\(self.currentPerson.Title)".lowercaseString)
            favorImage.append(self.currentPerson.Image)
        }
        
        // MDCSwipeToChooseView removes the view from the view hierarchy
        // after it is swiped (this behavior can be customized via the
        // MDCSwipeOptions class). Since the front card view is gone, we
        // move the back card to the front, and create a new back card.
        if(self.backCardView != nil){
            self.setFontCard(self.backCardView)
        }
        
        backCardView = self.popPersonViewWithFrame(self.backCardViewFrame())
        //if(true){
        // Fade the back card into view.
        if(backCardView != nil){
            self.backCardView.alpha = 0.0
            self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
                self.backCardView.alpha = 1.0
                },completion:nil)
        }
    }

    func setFontCard(frontCardView:CardView) -> Void{
        
        // Keep track of the person currently being chosen.
        // Quick and dirty, just for the purposes of this sample app.
        self.frontCardView = frontCardView
        self.currentPerson = frontCardView.person
    }
    
    func defaultPeople() -> [News]{
        // It would be trivial to download these from a web service
        // as needed, but for the purposes of this sample app we'll
        // simply store them in memory.
        return [News(name: "13 Ways of Staying Fit When There's No Time to Exercise".uppercaseString, image: UIImage(named: "finn"), author: "finn"), News(name: "11 Steps to Better Skin".uppercaseString, image: UIImage(named: "jake"), author: "jake"), News(name: "How Teens Can Stay Fit".uppercaseString, image: UIImage(named: "fiona"), author: "fiona"), News(name: "how to be cool".uppercaseString, image: UIImage(named: "prince"), author: "prince")]
        
    }
    func popPersonViewWithFrame(frame:CGRect) -> CardView?{
        if(self.people.count == 0){
            return nil;
        }
        
        // UIView+MDCSwipeToChoose and MDCSwipeToChooseView are heavily customizable.
        // Each take an "options" argument. Here, we specify the view controller as
        // a delegate, and provide a custom callback that moves the back card view
        // based on how far the user has panned the front card view.
        var options:MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        options.delegate = self
        //options.threshold = 160.0
        options.onPan = { state -> Void in
            if(self.backCardView != nil){
                var frame:CGRect = self.frontCardViewFrame()
                self.backCardView.frame = CGRectMake(frame.origin.x, frame.origin.y-(state.thresholdRatio * 10.0), CGRectGetWidth(frame), CGRectGetHeight(frame))
            }
        }
        
        // Create a personView with the top person in the people array, then pop
        // that person off the stack.
        
        var personView:CardView = CardView(frame: frame, person: self.people[0], options: options)
        self.people.removeAtIndex(0)
        return personView
        
    }
    func frontCardViewFrame() -> CGRect{
        var horizontalPadding:CGFloat = 0.1
        var topPadding:CGFloat = 60
        var bottomPadding:CGFloat = 100
        return CGRectMake(horizontalPadding,topPadding,CGRectGetWidth(self.view.frame) - (horizontalPadding * 2), CGRectGetHeight(self.view.frame) - bottomPadding)
    }
    func backCardViewFrame() ->CGRect{
        var frontFrame:CGRect = frontCardViewFrame()
        return CGRectMake(frontFrame.origin.x, frontFrame.origin.y + 10.0, CGRectGetWidth(frontFrame), CGRectGetHeight(frontFrame))
    }
    
    func nopeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.Left)
    }
    func likeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.Right)
    }
}
