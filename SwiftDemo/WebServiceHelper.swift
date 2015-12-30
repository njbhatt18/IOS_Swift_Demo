//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
protocol WebServiceHelperDelegate {
    func didFailWithError (errorIs : String, AndUrlIs  : String)
    func didSuccessResponseWithDictionary (responseIs : NSDictionary, AndUrlIs  : String)
    func didSuccessResponseWithArray (responseIs : NSArray, AndUrlIs  : String)

}

class WebServiceHelper: NSObject{

    
    var arrParamter : NSMutableArray!
    var strMethodName :NSString!
    var strURL : NSString!
    var resData : NSMutableData!
    var jsonString : NSString!
    var delegate : WebServiceHelperDelegate!

    
    
    override init() {
        super.init()
    }
    
   
    
    func callGetMethod()
    {
        let url = NSURL(string: strURL as String)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod="GET"
        let connection = NSURLConnection(request: request, delegate: self, startImmediately:true)
        if((connection) != nil)
        {
            resData = NSMutableData.init()
            connection?.start()
        }
    }
    func callPostMethod()
    {
        let url = NSURL(string: strURL as String)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod="POST"
        let tData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody=tData

        let connection = NSURLConnection(request: request, delegate: self, startImmediately:true)
        if((connection) != nil)
        {
            resData = NSMutableData.init()
            connection?.start()
        }
    }
    
    //NSURLConnection Delegate Event -
     func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        resData.length=0
    }
    
     func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        resData.appendData(data)
    }
    
     func connection(connection: NSURLConnection, didFailWithError error: NSError)
    {
        delegate.didFailWithError(error.description, AndUrlIs: strMethodName as String)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        do {
            if let response:AnyObject = try NSJSONSerialization.JSONObjectWithData(resData, options:NSJSONReadingOptions.MutableContainers) as? AnyObject {
                if response is NSDictionary
                {
                    delegate.didSuccessResponseWithDictionary(response as! NSDictionary, AndUrlIs: strMethodName as String)
                }
                else
                {
                    delegate.didSuccessResponseWithArray(response as! NSArray, AndUrlIs: strMethodName as String)

                }
                print(response)
            } else {
                print("Failed...")
            }
        } catch let serializationError as NSError {
            print(serializationError)
        }
        
    }
    

}

