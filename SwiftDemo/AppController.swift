//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit

class AppController: NSObject{

    
    override init() {
        super.init()
    }

    class func callWebServiceWithURL (urlIs : NSString, AndMethodNameIs : NSString, AndDelegateIs : WebServiceHelperDelegate) {
        
        let webserviceHelper = WebServiceHelper.init() as WebServiceHelper
        webserviceHelper.strURL=urlIs
        webserviceHelper.strMethodName=AndMethodNameIs
        webserviceHelper.delegate=AndDelegateIs
        webserviceHelper.callGetMethod()

    }
    
    class func saveUserData (objUser : User){
        let data = NSKeyedArchiver.archivedDataWithRootObject(objUser)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "User")
    }
    class func getUserObject() -> User{
        let data = NSUserDefaults.standardUserDefaults().objectForKey("User") as? NSData
        var users : User
        if(data != nil){
            users = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! User
        }else{
            users = User.init()
        }
        
        return users
    }
    
    
}

