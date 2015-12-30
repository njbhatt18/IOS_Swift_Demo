//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
class ImageLazyLoadingViewController: UIViewController {

    @IBOutlet var tblView : UITableView?
    var arrImageURL : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="Lazy Loading"

        tblView?.registerClass(CustomCell.self, forCellReuseIdentifier: "ImageLazyLoadCell")
        tblView?.registerNib(UINib(nibName: "ImageLazyLoadCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ImageLazyLoadCell")
        arrImageURL .addObject("http://www.clker.com/cliparts/A/Y/O/m/o/N/placeholder-md.png")
        arrImageURL .addObject("http://gapmedicalcenter.com/wp-content/uploads/male-placeholder.jpg")
        arrImageURL .addObject("http://bbvsh.com/wp-content/uploads/male-placeholder.jpg")
        arrImageURL .addObject("http://atplumbing.com.au/male_flash_placeholder.jpg")
        arrImageURL .addObject("http://solidcrunch.com/wp-content/uploads/2015/06/staff-thumb-placeholder-male.jpg")
        arrImageURL .addObject("http://www.clker.com/cliparts/A/Y/O/m/o/N/placeholder-md.png")
        arrImageURL .addObject("http://gapmedicalcenter.com/wp-content/uploads/male-placeholder.jpg")
        arrImageURL .addObject("http://bbvsh.com/wp-content/uploads/male-placeholder.jpg")
        arrImageURL .addObject("http://atplumbing.com.au/male_flash_placeholder.jpg")
        arrImageURL .addObject("http://solidcrunch.com/wp-content/uploads/2015/06/staff-thumb-placeholder-male.jpg")
        arrImageURL .addObject("http://www.clker.com/cliparts/A/Y/O/m/o/N/placeholder-md.png")
        arrImageURL .addObject("http://gapmedicalcenter.com/wp-content/uploads/male-placeholder.jpg")
        arrImageURL .addObject("http://bbvsh.com/wp-content/uploads/male-placeholder.jpg")
        arrImageURL .addObject("http://atplumbing.com.au/male_flash_placeholder.jpg")
        arrImageURL .addObject("http://solidcrunch.com/wp-content/uploads/2015/06/staff-thumb-placeholder-male.jpg")
    }
    
    //TableView Delegate Event -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImageURL.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ImageLazyLoadCell"
        var cell :  ImageLazyLoadCell?
        cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? ImageLazyLoadCell
        let strURL = arrImageURL .objectAtIndex(indexPath.row) as! NSString
    
        cell?.ivLazyLoad?.layer.masksToBounds=true
        cell?.ivLazyLoad?.layer.cornerRadius=(cell?.ivLazyLoad?.frame.size.width)!/2
        let b = (cell?.ivLazyLoad!.checkDownloadIsComplete())! as Bool
        if(b == false){
            cell?.ivLazyLoad?.downloadImage(NSURL(string: strURL as String)!, placeholder: UIImage(named: "placeholder.png"))
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 126
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

