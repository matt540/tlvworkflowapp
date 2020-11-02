//
//  AddNewSellerVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 30/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class AddNewSellerVC: UIViewController {

    @IBOutlet weak var txtFirstName: ACFloatingTextfield!
    @IBOutlet weak var txtLastName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtPhoneNo: ACFloatingTextfield!
    @IBOutlet weak var txtAddress: ACFloatingTextfield!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
//        self.dismissPopUpViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
    }
}
