//
//  AddDataPictureCell.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 06/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class AddDataPictureCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnDeleteImage: UIButton!
    
     var deleteClosure: (() -> ())?
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        deleteClosure?()
    }
}
