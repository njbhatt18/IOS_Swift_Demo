//
//  MyCell.h
//  TestCollectionViewWithXIB
//
//  Created by Quy Sang Le on 2/3/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell
{
    @IBOutlet var lblText : UILabel?
    @IBOutlet var iv : UIImageView?
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}