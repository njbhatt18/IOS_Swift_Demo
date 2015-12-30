//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit

class User: NSObject,NSCoding{

    
    var strUserName : NSString!
    var strFirstName :NSString!
    var strEmail : NSString!
    
    override init() {
        super.init()
    }
    
    
    required init(coder decoder: NSCoder){
        strUserName=decoder.decodeObjectForKey("strUserName") as! NSString
        strFirstName=decoder.decodeObjectForKey("strFirstName") as! NSString
        strEmail=decoder.decodeObjectForKey("strEmail") as! NSString

    }
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.strUserName, forKey: "strUserName")
        coder.encodeObject(self.strFirstName, forKey: "strFirstName")
        coder.encodeObject(self.strEmail, forKey: "strEmail")

    }
    
}

