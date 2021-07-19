//
//  ProductListCell.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 19/07/21.
//  Copyright © 2021 eSparkBiz. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet var imgProductImage: UIImageView!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var btnDownload: UIButton!
    @IBOutlet var btnTick: UIButton!
    
    var downComp : (()->())?
    var tickComp : (()->())?
    
    @IBAction func btnDownloadAction(_ sender: Any) {
        downComp?()
    }
    
    @IBAction func btnTickAction(_ sender: Any) {
        tickComp?()
    }
    
}
