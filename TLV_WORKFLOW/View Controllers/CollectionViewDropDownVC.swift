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
    
    var brandCompletion : (([AddProductSubcategory])->())?
    var category = 0
    var data: AddProductModel?
    var subCategory: [AddProductSubcategory] = []
    var arrayList:[AddProductSubcategory] = []
    var selectedCells: [Int] = []
    var selectedDataArray: [AddProductSubcategory]?
    var isMultiple = false
    var selectedString: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var params:[String : Any] = [:]
        params["key"] = serviceKey
        params["role_id"] = "3"
        params["user_id"] = "63"
        DispatchQueue.main.async {
            self.getSellerrDetail(params: params)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        if !isMultiple{
//            for data in subCategory{
//                data.isCategorySelected = false
//            }
//        }
//        if selectedDataArray!.count > 0{
//            //selectedDataArray?[0].isCategorySelected = false
//            print(selectedDataArray)
//        }
        
        
        
    print(selectedDataArray)
    }
    
    func getSellerrDetail(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: "add_seller_product_for_production_stage", params: params) { (responseDict, status) in
            self.data = AddProductModel(fromDictionary: responseDict as! [String : Any])
            self.subCategory = self.data!.data.categories[self.category].subcategories!
            
            self.selectedDataArray = self.subCategory.filter({ (list) -> Bool in
                
                for  i in self.selectedString{
                    if list.subCategoryName == i {
                        return true
                    }
                }
                return false
            })
            
            if self.selectedDataArray != nil{
                for selectedData in self.selectedDataArray!{
                    for i in 0..<self.subCategory.count {
                        if self.subCategory[i].id == selectedData.id{
                            self.subCategory[i].isCategorySelected = true
                        }
                    }
                }
            }
            
            self.dropDownTableView.reloadData()
        }
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tempVC") as! tempVC
        //vc.arrayList = self.subCategory.filter{$0.isCategorySelected == true}
        brandCompletion?(self.subCategory.filter{$0.isCategorySelected == true})
        self.dismissPopUpViewController()
//        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }
}
extension CollectionViewDropDownVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as! DropDownCell
        
        if subCategory[indexPath.row].isCategorySelected{
            cell.imgTickIcon.image = #imageLiteral(resourceName: "tick")
            print("selected is \(subCategory[indexPath.row].subCategoryName ?? "")")
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
                data.isCategorySelected = false
            }
            subCategory[indexPath.row].isCategorySelected = true
            print("didSelectRowAt selected is \(subCategory[indexPath.row].subCategoryName ?? "")")
        }
        tableView.reloadData()
    }
}
