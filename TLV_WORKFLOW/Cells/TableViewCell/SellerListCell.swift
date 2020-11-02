//
//  SellerListCell.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 28/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class SellerListCell: UITableViewCell {

    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnPhoneNo: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var lblProductCount: UILabel!
    
    var emailClosure: (()->())?
    var phonoNoClosure: (()->())?
    var addressClosure: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func btnEmailAction(_ sender: Any) {
        emailClosure?()
    }
    
    @IBAction func btnPhonoNoAction(_ sender: Any) {
        phonoNoClosure?()
    }
    
    @IBAction func btnAddressAction(_ sender: Any) {
        addressClosure?()
    }
    
}
