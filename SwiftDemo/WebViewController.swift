//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
class WebViewController: UIViewController {

    @IBOutlet var webView : UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Load Live URL
        webView!.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.google.co.in")!))
        self.navigationItem.title="WebView"
        
        //Load From Bundle
        let url = NSBundle.mainBundle().URLForResource("HTMLFile", withExtension:"html")
        let myRequest = NSURLRequest(URL: url!);
        webView!.loadRequest(myRequest);
        
        
    }
    //WebView Delegate Event
    func webViewDidStartLoad(webView: UIWebView)
    {
        
    }
    func webViewDidFinishLoad(webView: UIWebView){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

