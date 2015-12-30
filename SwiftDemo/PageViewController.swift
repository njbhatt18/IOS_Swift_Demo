//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
class PageViewController: UIViewController {

    @IBOutlet var scrView : UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets=false;
        self.navigationItem.title="PageView"
        for var i = 0; i < 10; i++ {
           // var vw = UIView(frame: CGRectMake(0,0, scrView?.frame.size.width,scrView?.frame.size.height))
             let x = CGFloat(i) * 320
             let vw = UIView(frame: CGRectMake(x,0, 320,504))
            vw.backgroundColor=UIColor(red: CGFloat(i)/50.0, green:CGFloat(i)/10.0, blue: CGFloat(i)/4.0, alpha: 1.0)
            //vw.backgroundColor=UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            print(NSStringFromCGRect(vw.frame))
            scrView?.addSubview(vw)
            scrView?.pagingEnabled=true
            scrView?.contentSize=CGSizeMake(vw.frame.origin.x+vw.frame.size.width, 504)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

