//
//  tempVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 04/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class tempVC: UIViewController {
    
    @IBOutlet weak var txtBrand: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtSubCategory: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet weak var txtCondition: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtMaterials: UITextField!
    
    var arrayList:AddProductSubcategory?
    
    var selectedDataArary:[AddProductSubcategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension tempVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBrand{
            txtBrand.resignFirstResponder()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewDropDownVC") as! CollectionViewDropDownVC
            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
            vc.category = 0
            vc.lblHeader.text = "Add Brand"
            vc.isMultiple = false
            vc.brandCompletion = {
                (list) in
                if list.count > 1{
                    let nameArr = list.map{$0.subCategoryName}
                    let name = nameArr.compactMap{$0}.joined(separator: ",")
                    self.txtBrand.text = name
                }else if list.count == 1{
                    self.txtBrand.text = list[0].subCategoryName
                }else{
                    
                }
            }
            if txtBrand.text != ""{
                let stringArray = txtBrand.text?.components(separatedBy: ",")
                vc.selectedString = stringArray!
            }
             //vc.selectedDataArray = self.selectedDataArary
            self.popUpEffectType = .flipUp
            self.presentPopUpViewController(vc)
//            self.navigationController?.present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        }else if textField == txtCategory{
            txtCategory.resignFirstResponder()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewDropDownVC") as! CollectionViewDropDownVC
            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
            vc.category = 1
            vc.lblHeader.text = "Add Brand"
            vc.isMultiple = true
            vc.brandCompletion = {
                (list) in
                self.selectedDataArary = list
                if list.count > 1{
                    let nameArr = list.map{$0.subCategoryName}
                    let name = nameArr.compactMap{$0}.joined(separator: ",")
                    self.txtCategory.text = name
                }else if list.count == 1{
                    self.txtCategory.text = list[0].subCategoryName
                }else{
                    
                }
            }
//             vc.selectedDataArray = self.selectedDataArary
            if txtCategory.text != ""{
                let stringArray = txtCategory.text?.components(separatedBy: ",")
                vc.selectedString = stringArray!
            }
            self.popUpEffectType = .flipUp
            self.presentPopUpViewController(vc)
        }else if textField == txtColor{
            txtColor.resignFirstResponder()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewDropDownVC") as! CollectionViewDropDownVC
            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
            vc.category = 3
            vc.lblHeader.text = "Add Color"
            vc.brandCompletion = {
                (list) in
                self.selectedDataArary = list
                if list.count > 1{
                    let nameArr = list.map{$0.subCategoryName}
                    let name = nameArr.compactMap{$0}.joined(separator: ",")
                    self.txtColor.text = name
                }else if list.count == 1{
                    self.txtColor.text = list[0].subCategoryName
                }else{
                    
                }
            }
             vc.selectedDataArray = self.selectedDataArary
            self.popUpEffectType = .flipUp
            self.presentPopUpViewController(vc)
        }
    }
}
