//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation
class MasterViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var player : AVPlayer? = nil
    var playerLayer : AVPlayerLayer? = nil
    var asset : AVAsset? = nil
    var playerItem: AVPlayerItem? = nil
    @IBOutlet var btnSelectPhoto : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var objUser = AppController.getUserObject()
        if(!(objUser.strEmail != nil)){

            let obj = User.init()
            obj.strUserName = "Nahim_OSSC"
            obj.strFirstName = "Nahim"
            obj.strEmail = "nahim@ossc.com"
            AppController.saveUserData(obj)
            objUser = AppController.getUserObject()
        }
        print(objUser.strEmail)
        print(objUser.strFirstName)
        print(objUser.strUserName)

        
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("Test App")
        picker.setMessageBody("Test message from us", isHTML: false)
      //  presentViewController(picker, animated: true, completion: nil)
        
        btnSelectPhoto.layer.masksToBounds=true
        btnSelectPhoto.layer.borderWidth=1.0
        btnSelectPhoto.layer.cornerRadius=5.0
        btnSelectPhoto.layer.borderColor=UIColor.grayColor().CGColor
        
        self.navigationItem.title="Home"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Custom Event-
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    @IBAction func showActivityIndicator(sender: UIButton){
        
        SwiftSpinner.show("Connecting \nto satellite...").addTapHandler({
            print("tapped")
            SwiftSpinner.hide()
            }, subtitle: "Tap to hide while connecting! This will affect only the current operation.")
    }

    
    @IBAction func setLocalNotification(sender: UIButton){
        
        let notificationSettings = UIUserNotificationSettings(forTypes : UIUserNotificationType.Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        let notification = UILocalNotification()
        let dateformat = NSDateFormatter() as NSDateFormatter!
        dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        notification.fireDate = (NSDate(timeIntervalSinceNow: 10))
        // notification.fireDate = dateformat.dateFromString(dateformat .stringFromDate(NSDate(timeIntervalSinceNow: 10)))
        print(notification.fireDate)
        notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    
    }
    @IBAction func btnSelectPhotoClick (sender : AnyObject)
    {
        let animator = UIDynamicAnimator.init(referenceView: btnSelectPhoto.superview!) as UIDynamicAnimator
        let snapBehaviour = UISnapBehavior(item: btnSelectPhoto, snapToPoint: CGPointMake(100, 100))
        snapBehaviour.damping=0.75
        animator .addBehavior(snapBehaviour)
      /*  var alertController : UIAlertController!
        alertController = UIAlertController.init(title: "Select Option", message: "Please Select Photo", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: { (action) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate=self
            imagePicker.sourceType=UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true,
                completion: nil)

        })
        alertController.addAction(cameraAction)
        
        let pickerAction = UIAlertAction(title: "PhotoLibrary", style: .Default, handler: { (action) -> Void in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate=self
            imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true,
                completion: nil)

            
        })
        alertController.addAction(pickerAction)
        presentViewController(alertController, animated: true, completion: nil)*/
        
    }
    @IBAction func btnCheckInternetConnection(sender: UIButton) {
        let status = Reachability().connectionStatus()
        switch status {
        case .Unknown, .Offline:
            print("Not connected")
        case .Online(.WWAN):
            print("Connected via WWAN")
        case .Online(.WiFi):
            print("Connected via WiFi")
        }
    }
    @IBAction func btnVidePlayClick (sender : AnyObject)
    {
        let videoURLWithPath = "http://www.sample-videos.com/video/mp4/480/big_buck_bunny_480p_1mb.mp4"
        
        let videoURL = NSURL(string: videoURLWithPath)
        asset = AVAsset.init(URL: videoURL!)
        playerItem = AVPlayerItem(asset: asset!)
        player = AVPlayer(playerItem: self.playerItem!)
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "playerItemDidReachEnd:",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: player!.currentItem)


        playerLayer = AVPlayerLayer(player: self.player)
        playerLayer!.frame = self.view.frame
        self.view.layer.addSublayer(self.playerLayer!)
        player!.play()
    }
    func playerItemDidReachEnd(notification: NSNotification) {
        player!.pause()
        self.playerLayer! .removeFromSuperlayer()
        
    }
    // ImagePickerControllerDelegate

     func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
     {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if(mediaType == "public.image")
        {
            btnSelectPhoto.setImage(info[UIImagePickerControllerOriginalImage] as?UIImage, forState: UIControlState.Normal)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
     }
     func imagePickerControllerDidCancel(picker: UIImagePickerController)
     {
        self.dismissViewControllerAnimated(true, completion: nil)

     }

    // MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    // UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        textField.autocorrectionType = .No
        return true;
    }
     func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        return true;
    }

}

