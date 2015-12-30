//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
import MessageUI

class TableViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,WebServiceHelperDelegate {
    var arrDetail : NSMutableArray = []
    var pasteBoard = UIPasteboard.generalPasteboard()

    @IBOutlet var tblView : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView?.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tblView?.registerNib(UINib(nibName: "CustomCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        
        AppController .callWebServiceWithURL("http://theappguruz.in//Apps/iOS/Temp/json.php", AndMethodNameIs:"http://theappguruz.in//Apps/iOS/Temp/json.php", AndDelegateIs: self)
        self.automaticallyAdjustsScrollViewInsets=false;
        self.navigationItem.title="TableView"
        self.navigationController?.navigationBarHidden=false
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//TableView Delegate Event -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDetail.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentifier = "CustomCell"
        var cell :  CustomCell?
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? CustomCell
        let obj = arrDetail .objectAtIndex(indexPath.row) as! Object
        cell!.lblText!.text=obj.strTitle as String!
        cell!.lblDetailText!.text=obj.strRoom as String!
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 100
    }
    func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        if (action == Selector("copy:")) {
            return true
        }
        return false
    }
    func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomCell
        pasteBoard.string = cell.lblText!.text
    }
    // WebServiceHelperDelegate
    func didSuccessResponseWithDictionary (responseIs : NSDictionary, AndUrlIs  : String)
    {
        if(AndUrlIs=="http://theappguruz.in//Apps/iOS/Temp/json.php")
        {
            print(responseIs)
                let arrKeyName = responseIs.allKeys as NSArray?
                for var j = 0; j < arrKeyName!.count; j++
                {
                    let strKey = arrKeyName?.objectAtIndex(j)
                    print(strKey)
                    let arrFinal = responseIs.objectForKey(strKey!) as! NSArray?
                    print(arrFinal!.count);

                    for var k = 0; k < arrFinal!.count; k++
                    {
                        let dictFinal = arrFinal?.objectAtIndex(k) as! NSDictionary
                        let obj = Object.init()
                        obj.strDetails=dictFinal.objectForKey("DETAILS") as! NSString
                        obj.strSpeaker=dictFinal.objectForKey("SPEAKER") as! NSString
                        obj.strTime=dictFinal.objectForKey("TIME") as! NSString
                        obj.strRoom=dictFinal.objectForKey("ROOM") as! NSString
                        obj.strTitle=dictFinal.objectForKey("TITLE") as! NSString
                        arrDetail.addObject(obj)
                        print(arrDetail.count);
                    }
                    tblView?.reloadData()
                }
        }
    }
    func didSuccessResponseWithArray (responseIs : NSArray, AndUrlIs  : String)
    {
        
    }
    func didFailWithError (errorIs : String, AndUrlIs  : String)
    {
        
    }
}

