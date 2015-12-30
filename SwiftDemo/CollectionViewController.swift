//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
import MessageUI

class CollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var arrDetail : NSMutableArray = []

    @IBOutlet var collectionVw : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets=false

        collectionVw?.registerClass(CustomCollectionCell.self, forCellWithReuseIdentifier: "CustomCollectionCell")
        collectionVw?.registerNib(UINib(nibName: "CustomCollectionCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "CustomCollectionCell")
        self.navigationItem.title="CollectionView"
        self.navigationController?.navigationBarHidden=false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//CollectionView Delegate Event -
    //1
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "CustomCollectionCell"

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionCell
        cell.iv?.image=UIImage(named: "\(self.getRandomNumber()).png")
        cell.lblText?.text="Image\(indexPath.row)"
        return cell
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSizeMake(96, 96)
    }
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool{
               return true
    }
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath,toIndexPath destinationIndexPath: NSIndexPath) {
        // swap values if sorce and destination
      //  let temp = characterArray[sourceIndexPath.row]
       // characterArray[sourceIndexPath.row] = characterArray[destinationIndexPath.row]
       // characterArray[destinationIndexPath.row] = temp
    }
    func getRandomNumber() -> Int{
        
        return Int(arc4random_uniform(UInt32((3 - 1) + 1))) + 1
    }
}



