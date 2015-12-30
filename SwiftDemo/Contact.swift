//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit

class Contact: NSObject{

    
    var strPrefix : NSString!
    var strFirstName :NSString!
    var strCompany : NSString!
    var arrEmailAddress : NSMutableArray = []
    var arrPhoneNumber : NSMutableArray = []
    var imgProfile : UIImage!
    override init() {
        super.init()
        

    }
}

