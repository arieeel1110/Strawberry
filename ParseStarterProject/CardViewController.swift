//
//  CardViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shumin Gao on 9/5/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import MDCSwipeToChoose
import Parse

//var favorTitle = [String]()
//var favorImage = [UIImage]()
//var favorAuthor = [String]()

class CardViewController: UIViewController,MDCSwipeToChooseDelegate,UIViewControllerTransitioningDelegate {
    
    var posts:[Post] = []
    var repeatObjects:[NSString] = []
    let ChoosePersonButtonHorizontalPadding:CGFloat = 80.0
    let ChoosePersonButtonVerticalPadding:CGFloat = 20.0
    var currentPerson:Post!
    var frontCardView:CardView!
    var backCardView:CardView!
    var textButton:UIButton!
    var category:String! = "weight"
    var darkBackground: UIView!
    
    let transitionManager = TransitionManager()
    
    var menuContainer: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.posts = defaultPeople()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.posts = defaultPeople()
        // Here you can init your properties
    }
    
    convenience init(){
        self.init()
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        setCards()
        
        addMenuContainer()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setCards() {
        // Display the first ChoosePersonView in front. Users can swipe to indicate
        // whether they like or dislike the person displayed.
        
        if posts.count != 0 {
            var newFrontCard = self.popPersonViewWithFrame(frontCardViewFrame()) as CardView!
            self.setFontCard(newFrontCard)
            self.view.addSubview(self.frontCardView)
        }
//        else{
//            if frontCardView != nil {
//                frontCardView.removeFromSuperview()
//            }
//        }
        
        if posts.count != 0 {
            self.backCardView = self.popPersonViewWithFrame(backCardViewFrame())!
            
            self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
        }
//        else{
//            if backCardView != nil {
//                backCardView.removeFromSuperview()
//            }
//        }
       
    }
    
    func buttonMoveToText() {
        let textButton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var bounds = UIScreen.mainScreen().bounds
        var width = bounds.size.width
        var height = bounds.size.height
        
        textButton.frame = CGRectMake(0, 0, width, height)
        
        //button.backgroundColor = UIColor.blackColor()
        //button.setTitle("Test Button", forState: UIControlState.Normal)
        
        textButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        textButton.tag=100
        
        frontCardView.addSubview(textButton)
    }
    
    var valueToPass:String!
    var picToPass:UIImage!
    var authorToPass:String!
    var titleToPass:String!
    
    func buttonAction(sender:UIButton!)
    {
        if sender.tag == 100{
            valueToPass = self.currentPerson.Text as? String
            picToPass = self.currentPerson.Picture as UIImage
            authorToPass = self.currentPerson.Author as String
            titleToPass = self.currentPerson.Title as String
            
            self.performSegueWithIdentifier("ViewText", sender: self)
        }
        else{
            if self.category != sender.titleLabel!.text {
                self.category = sender.titleLabel!.text
                
                if frontCardView != nil{
                    frontCardView.removeFromSuperview()
                }
                
                if backCardView != nil {
                    backCardView.removeFromSuperview()
                }
                
                menuContainer.hidden = true
                posts = defaultPeople()
                
                if (posts.count != 0) {
                    self.self.setCards()
                }
                
                addMenuContainer()
                
            }
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        
        if (segue.identifier == "ViewText") {
            
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destinationViewController as! TextViewController
            // your new view controller should have property that will store passed value
            viewController.passedText = valueToPass
            viewController.passedPic = picToPass
            viewController.passedAuthor = authorToPass
            viewController.passedTitle = titleToPass
            
            // instead of using the default transition animation, we'll ask
            // the segue to use our custom TransitionManager object to manage the transition animation
            //viewController.transitioningDelegate = self.transitionManager
            //viewController.modalPresentationStyle = .Custom
            
            println("hehe")

        }
        
    }
    
    
    @IBAction func Category(sender: AnyObject) {
        
        self.menuContainer.hidden = !self.menuContainer.hidden
        self.darkBackground.hidden = !self.darkBackground.hidden

    }
    
    
    func addMenuContainer(){
        
        self.darkBackground = UIView(frame:self.view.frame)
        self.darkBackground.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.darkBackground.hidden = true
        
        
        var frame:CGRect = CGRectMake(70,
            170, view.bounds.width-120,view.bounds.height-320)
        
        
        self.menuContainer=UIView(frame: frame)
        self.menuContainer.hidden = true
        self.menuContainer.layer.cornerRadius = 25
        self.menuContainer.backgroundColor=UIColor.whiteColor().colorWithAlphaComponent(0.1)
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        
        visualEffectView.frame = menuContainer.bounds
        
        visualEffectView.layer.cornerRadius = 15
        visualEffectView.clipsToBounds = true
        
        menuContainer.addSubview(visualEffectView)
        
        addButton()
        
        self.view.insertSubview(self.menuContainer,aboveSubview: self.frontCardView )
        self.view.insertSubview(self.darkBackground,belowSubview: self.menuContainer )
        
    }
    
    func addButton(){
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var leftpadding = menuContainer.bounds.origin.x+30
        var toppadding = menuContainer.bounds.origin.y + 60
        
        button.frame = CGRectMake(leftpadding, toppadding, 50, 50)
        
        let image = UIImage(named: "scale") as UIImage?
        let tintedImage = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button.setImage(image, forState: .Normal)
        button.tintColor = UIColor.blackColor()
        
        button.setTitle("weight", forState: .Normal)
        
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.tag=0
        
        // the space between the image and text
//        var spacing: CGFloat  = 6.0
//        
//        // lower the text and push it left so it appears centered
//        //  below the image
//        var imageSize = button.imageView!.frame.size as CGSize
//        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
//        
//        // raise the image and push it right so it appears centered
//        //  above the text
//        var titleSize = button.titleLabel!.frame.size as CGSize
//        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
        
        menuContainer.addSubview(button)
        
        //************* 2
        
        let button2   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var leftpadding2 = menuContainer.bounds.origin.x+110
        var toppadding2 = menuContainer.bounds.origin.y + 60
        
        button2.frame = CGRectMake(leftpadding2, toppadding2, 50, 50)
        
        let image2 = UIImage(named: "muscle") as UIImage?
        let tintedImage2 = image2?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button2.setImage(image2, forState: .Normal)
        button2.tintColor = UIColor.blackColor()


        button2.setTitle("muscle", forState: .Normal)
        
        button2.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.tag=1
        
        menuContainer.addSubview(button2)
        
        //************* 3
        
        let button3   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var leftpadding3 = menuContainer.bounds.origin.x+30
        var toppadding3 = menuContainer.bounds.origin.y + 150
        
        button3.frame = CGRectMake(leftpadding3, toppadding3, 50, 50)
        
        let image3 = UIImage(named: "meal") as UIImage?
        let tintedImage3 = image3?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button3.setImage(image3, forState: .Normal)
        button3.tintColor = UIColor.blackColor()
    
        button3.setTitle("meal", forState: .Normal)

        
        button3.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button3.tag=2
        
        menuContainer.addSubview(button3)
        
        //*********** 4
        
        let button4   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        var leftpadding4 = menuContainer.bounds.origin.x+110
        var toppadding4 = menuContainer.bounds.origin.y+150
        
        button4.frame = CGRectMake(leftpadding4, toppadding4, 50, 50)
        
        let image4 = UIImage(named: "Bikini") as UIImage?
        let tintedImage4 = image4?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button4.setImage(image4, forState: .Normal)
        button4.tintColor = UIColor.blackColor()
        
        button4.setTitle("idol", forState: .Normal)
        
        button4.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button4.tag=3
        
        menuContainer.addSubview(button4)
        
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
            
            fetchMorePost()
        }
        else{
            
//            println("You liked: \(self.currentPerson.Title)")
            
//            favorTitle.append("\(self.currentPerson.Title)".lowercaseString)
//            favorImage.append(self.currentPerson.Image)
//            favorAuthor.append("\(self.currentPerson.Author)")
            var query = PFQuery(className:"Post")
            var currentObject = query.getObjectWithId(self.currentPerson.objectId as! String) as PFObject!
            currentObject.incrementKey("like_count")

            var user = PFUser.currentUser()
            var relation = user!.relationForKey("likes")
            relation.addObject(currentObject)
            
            currentObject.saveInBackground()
            user!.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println("like this post")
                    //println(relation.query()?.findObjects())
                } else {
                    // There was a problem, check error.description
                }
            }
            
            fetchMorePost()
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
        self.currentPerson = frontCardView.post
        buttonMoveToText()
    }
    
    func defaultPeople() -> [Post]{
        
        // get repeat objectId list
//        self.repeatObjects = getRepeatObjects()
        
        // It would be trivial to download these from a web service
        // as needed, but for the purposes of this sample app we'll
        // simply store them in memory.
        
        var cards:[Post] = []
        
        var query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
//        query.whereKey("objectId", notContainedIn: self.repeatObjects)
        query.limit = 3
        query.whereKey("category", equalTo: self.category)
        var objects = query.findObjects() as! [PFObject]

                    for object in objects {
                        
//                        if cardCategoty != self.category {
//                            continue
//                        }
                        
                        println("added")
                        
                        //author
                        let author = object.valueForKey("uploader") as! PFUser
                        author.fetchIfNeeded()
                        
                        //authorName
                        var authorName = author.username
                        
                            //title
                        var title = object.valueForKey("title") as! NSString
                        
                        var likes = object.valueForKey("like_count") as! NSNumber
                        
                            //image
                        var userImageFile = object.valueForKey("imageFile") as? PFFile
                        
                        var image = UIImage(data: userImageFile!.getData()!)
                        
                        var picFile = author.valueForKey("profilePicture") as? PFFile
                        
                        var pic: UIImage
                        
                        if picFile != nil {
                            pic = UIImage(data: picFile!.getData()!)!
                        }
                        else {
                            pic = UIImage(named:"star")!
                        }
      
                        //text
                        var text = object.valueForKey("imageText") as! NSString
                        
                        // mark it as repeat object
                        var objectId = object.valueForKey("objectId") as! NSString
                        self.repeatObjects.append(objectId)
//                        saveRepeatObject(objectId)
                        
                        cards.append(Post(name: title,image: image, author: authorName, text:text, pic: pic, objectId: objectId, likes: likes))
                }
        
            return cards
        
    }
    
    func fetchMorePost() -> Void {
        
        var query = PFQuery(className: "Post")
        query.whereKey("objectId", notContainedIn: self.repeatObjects)
        query.whereKey("category", equalTo: self.category)
        
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            
            if error != nil && object != nil {
                
                let author = object?.valueForKey("uploader") as! PFUser
                author.fetchIfNeeded()
                
                //authorName
                var authorName = author.username
                
                //title
                var title = object?.valueForKey("title") as! NSString
                
                var likes = object?.valueForKey("like_count") as! NSNumber
                
                //image
                var userImageFile = object?.valueForKey("imageFile") as? PFFile
                
                var image = UIImage(data: userImageFile!.getData()!)
                
                var picFile = author.valueForKey("profilePicture") as? PFFile
                
                var pic: UIImage
                
                if picFile != nil {
                    pic = UIImage(data: picFile!.getData()!)!
                }
                else {
                    pic = UIImage(named:"star")!
                }
                
                //text
                var text = object?.valueForKey("imageText") as! NSString
                
                // mark it as repeat object
                var objectId = object?.valueForKey("objectId") as! NSString
                self.repeatObjects.append(objectId)
                //            self.saveRepeatObject(objectId)
                
                var post = Post(name: title,image: image, author: authorName, text:text, pic: pic, objectId:objectId, likes: likes )
                
                self.posts.append(post)

            } else {
                // The find succeeded.
                println("error")
            }
        }
    }
    
    func popPersonViewWithFrame(frame:CGRect) -> CardView?{
        
        if(self.posts.count == 0){
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
        
        var personView:CardView = CardView(frame: frame, post: self.posts[0], options: options)
        self.posts.removeAtIndex(0)
        return personView
        
    }
    
//    func saveRepeatObject(objectId: NSString) -> Void {
//        let repeat = PFObject(className:"Repeat")
//        repeat["objectId"] = objectId
//        repeat.pinInBackground()
//    }
//    
//    func getRepeatObjects() -> [NSString] {
//        var repeatObjects:[NSString] = []
//        var query = PFQuery(className:"Repeat")
//        query.fromLocalDatastore()
//        
//        var objects = query.findObjects() as! [PFObject]
//        for object in objects {
//            let objectId = object["objectId"] as! NSString
//            repeatObjects.append(objectId)
//        }
//        println(repeatObjects)
//        return repeatObjects
//    }
    
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
