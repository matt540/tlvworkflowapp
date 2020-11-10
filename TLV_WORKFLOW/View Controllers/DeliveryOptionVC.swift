//
//  DeliveryOptionVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 10/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class DeliveryOptionVC: UIViewController {

    var deleveryOptions:[String] = []
    var deleveryCompletion : ((String)->())?
    
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        self.dismissPopUpViewController()
    }
    
}

extension DeliveryOptionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deleveryOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.dropDownCell) as! DropDownCell
        cell.lblName.text = deleveryOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleveryCompletion?(deleveryOptions[indexPath.row])
        self.dismissPopUpViewController()
    }
}

