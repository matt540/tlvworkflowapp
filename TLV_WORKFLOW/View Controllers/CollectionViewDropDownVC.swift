//
//  CollectionViewDropDownVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 05/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class CollectionViewDropDownVC: UIViewController {

    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var dropDownTableView: UITableView!
    
    var brandCompletion : (([AddProductSubcategory],Int)->())?
    var category = 0
    var subCategory: [AddProductSubcategory] = []
    var isMultiple = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        brandCompletion?(self.subCategory.filter{$0.isCategorySelected == true},category)
        self.dismissPopUp()
    }
}

extension CollectionViewDropDownVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.dropDownCell) as! DropDownCell
        
        if subCategory[indexPath.row].isCategorySelected{
            cell.imgTickIcon.image = #imageLiteral(resourceName: "tick")
        }else{
            cell.imgTickIcon.image = UIImage()
        }
        
        cell.lblName.text = self.subCategory[indexPath.row].subCategoryName
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isMultiple{
            if subCategory[indexPath.row].isCategorySelected{
                subCategory[indexPath.row].isCategorySelected = false
            }else{
                subCategory[indexPath.row].isCategorySelected = true
            }
        }else{
            for data in subCategory{
                if data.subCategoryName != subCategory[indexPath.row].subCategoryName {
                    data.isCategorySelected = false
                }
            }
            if subCategory[indexPath.row].isCategorySelected{
                subCategory[indexPath.row].isCategorySelected = false
            }else{
                subCategory[indexPath.row].isCategorySelected = true
            }
        }
        tableView.reloadData()
    }
}
