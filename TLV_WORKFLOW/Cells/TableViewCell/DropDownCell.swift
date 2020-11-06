//
//  DropDownCell.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 05/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgTickIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
