//
//  ProductDetailCell.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 28/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {

    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var lblSKU: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductWidth: UILabel!
    @IBOutlet weak var lblProductDepth: UILabel!
    @IBOutlet weak var lblProductHeight: UILabel!
    @IBOutlet weak var btnRadioArchive: UIButton!
    @IBOutlet weak var btnRadioDelete: UIButton!
    @IBOutlet weak var btnRadioSubmit: UIButton!
    @IBOutlet weak var lblViewProduct: UILabel!
    @IBOutlet weak var btnSubmitForPrice: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    
    var archiveClosure: (() -> ())?
    var submitClosure: (() -> ())?
    var deleteClosure: (() -> ())?
    var submitForPriceClosure: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnRadioArchiveAction(_ sender: Any) {
        archiveClosure?()
    }
    @IBAction func btnRadioDeleteAction(_ sender: Any) {
        deleteClosure?()
    }
    @IBAction func btnRadioSubmitAction(_ sender: Any) {
        submitClosure?()
    }
    @IBAction func btnSubmitPricingAction(_ sender: Any) {
        submitForPriceClosure?()
    }
    

}
