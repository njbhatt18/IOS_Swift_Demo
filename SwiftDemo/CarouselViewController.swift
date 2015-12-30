//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        let carousel = iCarousel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        carousel.dataSource = self
        carousel.type = .CoverFlow
        view.addSubview(carousel)
        self.navigationItem.title="Carousel"
    }
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        let imageView: UIImageView
        
        if view != nil {
            imageView = view as! UIImageView
        } else {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        }
        
        imageView.image = UIImage(named: "1.png")
        
        return imageView
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

