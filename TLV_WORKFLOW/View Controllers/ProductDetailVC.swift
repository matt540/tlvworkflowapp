//
//  ProductDetailVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 28/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage

//You are currently offline. You can add products in offline mode and sync them once a wireless connection is established.

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnRadioArchive: UIButton!
    @IBOutlet weak var btnRadioDelete: UIButton!
    @IBOutlet weak var btnRadioSubmit: UIButton!
    @IBOutlet weak var btnAddProduct: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var tblProductDetail: UITableView!
    
    
    var pageCount: Int!
    var searchText = ""
    var sellerDetail: SellerListData?
    var productArray: [ProductData] = []
    var arrayDeleteIds: [Int] = []
    var arrayArchiveIds: [Int] = []
    var arraySubmitIds: [Int] = []
    var refreshControl = UIRefreshControl()
    var imgArray = [#imageLiteral(resourceName: "user_icon"),#imageLiteral(resourceName: "logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageCount = 1
        btnPrevious.isHidden = true
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblProductDetail.addSubview(refreshControl)
        let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.callGetProductListService(params: params)
        }
    }
}

//MARK: Button Action Events
extension ProductDetailVC {
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if arrayArchiveIds.count == 0 || arrayArchiveIds.isEmpty {
            alertbox(title: Messages.error, message: Messages.archiveEmptyAlert)
        }else {
            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmArchiveProduct, action1: "Yes", action2: "No") { (status) in
                if status == 0 {
                    var paramDict: [String : Any] = [:]
                    paramDict[Constant.ParameterNames.key] = serviceKey
                    paramDict[Constant.ParameterNames.production_quotation_ids] = self.arrayArchiveIds
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callSaveService(params: paramDict)
                    }
                    
                }
            }
        }
    }
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        if arrayDeleteIds.count == 0 || arrayDeleteIds.isEmpty {
            alertbox(title: Messages.error, message: Messages.deleteEmptyAlert)
        }else {
            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmDeleteProdut, action1: "Yes", action2: "No") { (status) in
                if status == 0 {
                    var paramDict: [String : Any] = [:]
                    paramDict[Constant.ParameterNames.key] = serviceKey
                    paramDict[Constant.ParameterNames.production_quotation_ids] = self.arrayDeleteIds
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callDeleteService(params: paramDict)
                    }
                    
                }
            }
        }
    }
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        if arraySubmitIds.count == 0 || arraySubmitIds.isEmpty {
            alertbox(title: Messages.error, message: Messages.submitEmptyAlert)
        }else {
            multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmSubmitProduct, action1: "Yes", action2: "No") { (status) in
                if status == 0 {
                    var paramDict: [String : Any] = [:]
                    paramDict[Constant.ParameterNames.key] = serviceKey
                    paramDict[Constant.ParameterNames.production_quotation_ids] = self.arraySubmitIds
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callSubmitMultipalProduct(params: paramDict)
                    }
                    
                }
            }
        }
    }
    @IBAction func btnRadioButtonActions(_ sender: UIButton) {
        switch  sender {
        case btnRadioArchive:
            btnRadioDelete.isSelected = false
            btnRadioSubmit.isSelected = false
            if sender.isSelected{
                sender.isSelected = false
                arraySubmitIds = []
                arrayArchiveIds = []
                arrayDeleteIds = []
                tblProductDetail.reloadData()
            }else {
                sender.isSelected = true
                arraySubmitIds = []
                arrayDeleteIds = []
                for product in productArray{
                    arrayArchiveIds.append(product.id)
                }
                print(arrayArchiveIds)
                tblProductDetail.reloadData()
            }
            break
        case btnRadioDelete:
            btnRadioSubmit.isSelected = false
            btnRadioArchive.isSelected = false
            if sender.isSelected{
                sender.isSelected = false
                arraySubmitIds = []
                arrayArchiveIds = []
                arrayDeleteIds = []
                tblProductDetail.reloadData()
            }else {
                sender.isSelected = true
                arraySubmitIds = []
                arrayArchiveIds = []
                for product in productArray{
                    arrayDeleteIds.append(product.id)
                }
                tblProductDetail.reloadData()
            }
            break
        case btnRadioSubmit:
            btnRadioDelete.isSelected = false
            btnRadioArchive.isSelected = false
            if sender.isSelected{
                sender.isSelected = false
                arraySubmitIds = []
                arrayArchiveIds = []
                arrayDeleteIds = []
                tblProductDetail.reloadData()
            }else{
                sender.isSelected = true
                arrayDeleteIds = []
                arrayArchiveIds = []
                for product in productArray{
                    arraySubmitIds.append(product.id)
                }
                tblProductDetail.reloadData()
            }
            break
        default:
            break
        }
    }
    @IBAction func btnProfileAction(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender as UIView,
                                    with: ["My Profile","Logout"],
                                    menuImageArray: imgArray,
                                    done: { (selectedIndex) -> () in
                                        if selectedIndex == 0{
                                            
                                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.profileVC) as! ProfileVC
                                            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 80 )
                                            self.popUpEffectType = .flipUp
                                            self.presentPopUpViewController(vc)
                                            
                                        }else{
                                            
                                        }
        }) {
            
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddProductAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoVC
        popUpEffectType = .flipUp
        self.presentPopUpViewController(vc)
    }
    @IBAction func btnNextAction(_ sender: UIButton) {
        pageCount += 1
        let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.callGetProductListService(params: params)
        })
    }
    @IBAction func btnPreviousAction(_ sender: UIButton) {
        pageCount -= 1
        let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.callGetProductListService(params: params)
        })
    }
    
}

//MARK: TextField Methods
extension ProductDetailVC: UITextFieldDelegate{

    @IBAction func txtFieldDidChange(_ sender: UITextField) {
        GlobalFunction.hideLoadingIndicator()
        let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: sender.text!, userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.callGetProductListService(params: params)
        })
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: TableView Methods
extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.productDetailCell) as! ProductDetailCell
        let data = productArray[indexPath.row]
        if data.image != nil {
            let imageResponse = data.image!
            let imageItem = imageResponse.components(separatedBy: ",")
            let imgUrl = image_base_url+imageItem[0]
            detailCell.imgProductImage!.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }else {
            detailCell.imgProductImage.image = UIImage()
        }
        detailCell.lblSKU.text = data.sku
        detailCell.lblProductName.text = data.name
        detailCell.lblProductHeight.text = data.height
        detailCell.lblProductWidth.text = data.width
        detailCell.lblProductDepth.text = data.depth
        detailCell.lblDate.text = GlobalFunction.formattedDateFromString(dateString: data.forProductionCreatedAt.date!, withFormat: "MM-dd-yyyy")
        
        if arrayDeleteIds.contains(data.id){
            detailCell.btnRadioDelete.isSelected = true
            detailCell.btnRadioSubmit.isSelected = false
            detailCell.btnRadioArchive.isSelected = false
        }else if arraySubmitIds.contains(data.id){
            detailCell.btnRadioSubmit.isSelected = true
            detailCell.btnRadioDelete.isSelected = false
            detailCell.btnRadioArchive.isSelected = false
        }else if arrayArchiveIds.contains(data.id){
            detailCell.btnRadioArchive.isSelected = true
            detailCell.btnRadioDelete.isSelected = false
            detailCell.btnRadioSubmit.isSelected = false
        } else {
            detailCell.btnRadioDelete.isSelected = false
            detailCell.btnRadioSubmit.isSelected = false
            detailCell.btnRadioArchive.isSelected = false
        }
        
//        if data.isArchive {
//            detailCell.btnRadioArchive.isSelected = true
//            detailCell.btnRadioSubmit.isSelected = false
//            detailCell.btnRadioDelete.isSelected = false
//        }else if data.isSubmit{
//            detailCell.btnRadioSubmit.isSelected = true
//            detailCell.btnRadioArchive.isSelected = false
//            detailCell.btnRadioDelete.isSelected = false
//        }else if data.isDelete{
//            detailCell.btnRadioDelete.isSelected = true
//            detailCell.btnRadioArchive.isSelected = false
//            detailCell.btnRadioSubmit.isSelected = false
//        }else {
//            detailCell.btnRadioArchive.isSelected = false
//            detailCell.btnRadioSubmit.isSelected = false
//            detailCell.btnRadioDelete.isSelected = false
//        }
        
        detailCell.archiveClosure = {
            data.isArchive = data.isArchive ? false : true
            if data.isArchive {
                if !self.arrayArchiveIds.contains(data.id){
                    self.arrayArchiveIds.append(data.id)
                }
            }else {
                if self.arrayArchiveIds.contains(data.id){
                    self.arrayArchiveIds = self.arrayArchiveIds.filter{ $0 != data.id }
                }
            }
            data.isDelete = false
            data.isSubmit = false
            self.tblProductDetail.reloadData()
        }
        detailCell.deleteClosure = {
            data.isDelete = data.isDelete ? false : true
            if data.isDelete {
                if !self.arrayDeleteIds.contains(data.id){
                    self.arrayDeleteIds.append(data.id)
                }
            }else {
                if self.arrayDeleteIds.contains(data.id){
                    self.arrayDeleteIds = self.arrayDeleteIds.filter{ $0 != data.id }
                }
            }
            data.isArchive = false
            data.isSubmit = false
            self.tblProductDetail.reloadData()
        }
        detailCell.submitClosure = {
            data.isSubmit = data.isSubmit ? false : true
            if data.isSubmit {
                if !self.arraySubmitIds.contains(data.id){
                    self.arraySubmitIds.append(data.id)
                }
            }else {
                if self.arraySubmitIds.contains(data.id){
                    self.arraySubmitIds = self.arraySubmitIds.filter{ $0 != data.id }
                }
            }
            data.isArchive = false
            data.isDelete = false
            self.tblProductDetail.reloadData()
        }
        detailCell.submitForPriceClosure = {
            var dictParam: [String : Any] = [:]
            dictParam[Constant.ParameterNames.key] = serviceKey
            dictParam[Constant.ParameterNames.id] = data.id!
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callSubmitForPricing(params: dictParam)
            }
        }
        return detailCell
    }
    
    
}

//MARK: Web Service Call
extension ProductDetailVC{
    func callGetProductListService(params: [String : Any]) {
        
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_sellers_products, params: params) { (responseDict, status) in
            
             let productsDetails = ProductModel(fromDictionary: responseDict as! [String : Any])
            if status == 0 {
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else {
               
                if productsDetails.data.data.isEmpty {
                    self.alertbox(title: Messages.error, message: Messages.noDataAvialable)
                    if self.pageCount > 1{
                        self.pageCount -= 1
                    }
                }else {
                    self.productArray = productsDetails.data.data
                    if self.pageCount > 1{
                        self.btnPrevious.isHidden = false
                    }else {
                        self.btnPrevious.isHidden = true
                    }
                    self.tblProductDetail.reloadData()
                }
            }
        }
    }
    
    func callSubmitForPricing(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.submit_for_pricing, params: params) { (responseDict, status) in
            
            if responseDict.isEmpty {
                self.alertbox(title: "TLV", message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    self.multiOptionAlertBox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alertbox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String)
                }
            }
        }
    }
    
    func callSaveService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.archive_product_qoutation, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: "TLV", message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    self.multiOptionAlertBox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alertbox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String)
                }
            }
        }
    }
    func callDeleteService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.delete_product_qoutation, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: "TLV", message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    self.multiOptionAlertBox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alertbox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String)
                }
            }
        }
    }
    func callSubmitMultipalProduct(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.submit_multiple_product_for_pricing, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: "TLV", message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    self.multiOptionAlertBox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alertbox(title: responseDict["status"]! as! String, message: responseDict["message"]! as! String)
                }
            }
        }
    }
}

//MARK: refresh method
extension ProductDetailVC {
    @objc func refresh(_ sender: AnyObject) {
       
       let params = apiParameters(serviceKeyData: serviceKey, pageCountData: pageCount, searchString: "", userId: currentLoginUser.data.id, roleId: currentLoginUser.data.roles[0].id, sellerId: sellerDetail!.id)
       GlobalFunction.showLoadingIndicator()
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           self.callGetProductListService(params: params)
       }
        refreshControl.endRefreshing()
    }
    
    func apiParameters(serviceKeyData: String, pageCountData: Int, searchString: String, userId: Int, roleId: Int, sellerId: Int) -> [String: Any]{
        var sellerDetailsParams: [String : Any] = [:]
        sellerDetailsParams[Constant.ParameterNames.key] = serviceKeyData
        sellerDetailsParams[Constant.ParameterNames.page] = pageCountData
        sellerDetailsParams[Constant.ParameterNames.role_id] = roleId
        sellerDetailsParams[Constant.ParameterNames.search] = searchString
         sellerDetailsParams[Constant.ParameterNames.seller_id] = sellerId
        sellerDetailsParams[Constant.ParameterNames.user_id] = userId
        return sellerDetailsParams
    }
}
