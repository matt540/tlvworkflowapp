//
//  SubCategoryVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 09/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class SubCategoryVC: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var subCategoryTableView: UITableView!
    
    var subCategory: [AddProductSubcategory] = []
    var subCategoryCompletion : (([[AddProductChildren]])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subCategoryTableView.reloadData()
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        var selectedChildren: [[AddProductChildren]] = []
        for i in subCategory{
            selectedChildren.append(i.childrens.filter{$0.isCategorySelected == true} )
        }
        subCategoryCompletion?(selectedChildren)
        self.dismissPopUp()
    }
}

extension SubCategoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategory[section].childrens.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return subCategory[section].subCategoryName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.subCategoryCell) as! SubCategoryCell
        
        if subCategory[indexPath.section].childrens[indexPath.row].isCategorySelected {
            cell.imgTickIcon.image = #imageLiteral(resourceName: "tick")
        }else{
            cell.imgTickIcon.image = UIImage()
        }
        
        cell.lblName.text = subCategory[indexPath.section].childrens[indexPath.row].subCategoryName
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if subCategory[indexPath.section].childrens[indexPath.row].isCategorySelected{
            subCategory[indexPath.section].childrens[indexPath.row].isCategorySelected = false
        }else{
            subCategory[indexPath.section].childrens[indexPath.row].isCategorySelected = true
        }
        tableView.reloadData()
    }
    
}
