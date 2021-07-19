//
//  ProductInnerVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 19/07/21.
//  Copyright © 2021 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage

class ProductInnerVC: BaseViewController {

    @IBOutlet var imgProductImage: UIImageView!
    @IBOutlet weak var lblSKU: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductWidth: UILabel!
    @IBOutlet weak var lblProductDepth: UILabel!
    @IBOutlet weak var lblProductHeight: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnRadioArchive: UIButton!
    @IBOutlet weak var btnRadioDelete: UIButton!
    @IBOutlet weak var btnRadioSubmit: UIButton!
    @IBOutlet weak var btnSubmitForPrice: UIButton!
    @IBOutlet var btnDownload: UIButton!
    
    var productData = ProductData(fromDictionary: [:])
    var sellerDetail: SellerListData?
    var imgArray = [#imageLiteral(resourceName: "user_icon"),#imageLiteral(resourceName: "logout")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
    }
    
    @IBAction func btnViewProductAction(_ sender: Any) {
        if GlobalFunction.isNetworkReachable(){
            let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.addProductVC) as! AddProductVC
            addProductVC.isEditView = true
            addProductVC.sellerId = sellerDetail?.id
            addProductVC.productId = productData.id
            self.navigationController?.pushViewController(addProductVC, animated: true)
        }else{
            if self.productData.isDownloaded == true{
                let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.addProductVC) as! AddProductVC
                addProductVC.isEditView = true
                addProductVC.sellerId = sellerDetail?.id
                addProductVC.productId = productData.id
                self.navigationController?.pushViewController(addProductVC, animated: true)
            }else{
                UIApplication.shared.windows.first?.makeToast(Messages.noInternet)
            }
        }
    }
    
    @IBAction func btnSubmitForPricingAction(_ sender: Any) {
        multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmSubmitProduct, action1: "Yes", action2: "No") { (status) in
            if status == 0 {
                var dictParam: [String : Any] = [:]
                dictParam[Constant.ParameterNames.key] = serviceKey
                dictParam[Constant.ParameterNames.id] = self.productData.id
                GlobalFunction.showLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.callSubmitForPricing(params: dictParam)
                }
            }
        }
    }
    
    @IBAction func btnDownloadAction(_ sender: Any) {
        if self.productData.isDownloaded == false{
            if GlobalFunction.isNetworkReachable(){
                self.offlineProductData()
                self.btnDownload.isSelected = true
            }else{
                UIApplication.shared.windows.first?.makeToast(Messages.noInternet)
            }
        }else{
            self.deleteProductData()
        }
    }
    
    @IBAction func btnArchiveAction(_ sender: Any) {
        multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmArchiveProduct, action1: "Yes", action2: "No") { (status) in
            if status == 0 {
                var paramDict: [String : Any] = [:]
                paramDict[Constant.ParameterNames.key] = serviceKey
                paramDict[Constant.ParameterNames.product_quotation_ids] = [self.productData.id]
                GlobalFunction.showLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.callSaveService(params: paramDict)
                }
                
            }
        }
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmDeleteProdut, action1: "Yes", action2: "No") { (status) in
            if status == 0 {
                var paramDict: [String : Any] = [:]
                paramDict[Constant.ParameterNames.key] = serviceKey
                paramDict[Constant.ParameterNames.product_quotation_ids] = [self.productData.id]
                GlobalFunction.showLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.callDeleteService(params: paramDict)
                }
                
            }
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        multiOptionAlertBox(title: Messages.confirm, message: Messages.confirmSubmitProduct, action1: "Yes", action2: "No") { (status) in
            if status == 0 {
                var paramDict: [String : Any] = [:]
                paramDict[Constant.ParameterNames.key] = serviceKey
                paramDict[Constant.ParameterNames.product_quotation_ids] = [self.productData.id]
                GlobalFunction.showLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.callSubmitMultipalProduct(params: paramDict)
                }
                
            }
        }
    }
    
    @IBAction func btnProfileAction(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender as UIView, with: ["My Profile","Logout"], menuImageArray: imgArray, done: { (selectedIndex) -> () in
            if selectedIndex == 0{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.profileVC) as! ProfileVC
                vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 80 )
                self.presentPopUp(vc)
            }else{
                self.multiOptionAlertBox(title: Messages.tlv, message: Messages.logoutMsg, action1: "YES", action2: "NO") { (Status) in
                    if Status == 0{
                        UserDefaults.standard.removeObject(forKey: Constant.UserDefaultKeys.currentUserModel)
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.loginVC) as! LoginVC
                        self.navigationController?.pushViewController(loginVC, animated: true)
                    }else{
                        
                    }
                }
            }
        }) {
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setValues() {
        if productData.isDownloaded{
            self.btnDownload.isSelected = true
        }else{
            self.btnDownload.isSelected = false
        }
        if productData.image != nil {
            let imageResponse = productData.image!
            let imageItem = imageResponse.components(separatedBy: ",")
            let imgUrl = image_base_url+imageItem[0]
            self.imgProductImage!.sd_setImage(with: URL(string: imgUrl), completed: nil)
        }else {
            self.imgProductImage.image = UIImage()
        }
        self.lblSKU.text = productData.sku
        self.lblProductName.text = productData.name
        self.lblProductHeight.text = productData.height
        self.lblProductWidth.text = productData.width
        self.lblProductDepth.text = productData.depth
        self.lblDate.text = GlobalFunction.formattedDateFromString(dateString: productData.forProductionCreatedAt.date!, withFormat: "MM-dd-yyyy")
    }
    
    func unSelectButton(){
        self.btnRadioArchive.isSelected = false
        self.btnRadioDelete.isSelected = false
        self.btnRadioSubmit.isSelected = false
    }
    
    func deleteProductData(){
        self.multiOptionAlertBox(title: Messages.tlv, message: Messages.confirmDeleteData, action1: "Yes",action2: "No") { (actionStatus) in
            if actionStatus == 0{
                self.productData.isDownloaded = false
                DataInfo().deleteProductDataDetail(productId: self.productData.id)
                DataInfo().deleteEditImageDataId(id: self.productData.id)
                self.btnDownload.isSelected = false
            }
        }
    }
    
    func offlineProductData(){
        var dictParam: [String : Any] = [:]
        dictParam[ Constant.ParameterNames.key ] = serviceKey
        dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
        dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
        dictParam[ Constant.ParameterNames.id] = productData.id
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            GlobalFunction.showLoadingIndicator()
            self.getDataToEditSellerProduct(params: dictParam)
        }
    }
    
    func getDataToEditSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.edit_seller_product_for_production_stage, params: params) { (responseDict, status) in
            if status == 200{
                if DataInfo().isProductDataDetailExists(productId: params[Constant.ParameterNames.id] as! Int){
                    DataInfo().deleteProductDataDetail(productId: params[Constant.ParameterNames.id] as! Int)
                    DataInfo().deleteEditImageDataId(id: params[Constant.ParameterNames.id] as! Int)
                }
                let JsonData = try?JSONSerialization.data(withJSONObject: responseDict as! [String : Any], options: [])
                let productDataOffline = String(data: JsonData!, encoding: .utf8)!
                let productData = AddProductModel(fromDictionary: responseDict as! [String : Any])
                DataInfo().createProductData(productId: params[Constant.ParameterNames.id] as! Int, productData: productDataOffline)
                let image = productData.data.product.productId.productPendingImages ?? []
                GlobalFunction.hideLoadingIndicator()
                for i in 0..<image.count{
                    let data = try? Data(contentsOf: URL(string: image_base_url + image[i].name)!)
                    DataInfo().createEditImageData(productId: params[Constant.ParameterNames.id] as! Int, imageData: data!, status: 1)
                    if i == image.count - 1 {
                        GlobalFunction.hideLoadingIndicator()
                    }
                }
                self.downloadCheck()
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    func downloadCheck(){
        let offlineProductData = DataInfo().retriveProductDataDetails()
        var ids = [Int]()
        for i in offlineProductData{
            ids.append(Int(i.product_id))
        }
        for i in ids{
            if i == productData.id{
                self.productData.isDownloaded = true
                self.btnDownload.isSelected = true
            }
        }
    }
    
    func callSaveService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.archive_product_qoutation, params: params) { (responseDict, status) in
            if status == 200 {
                GlobalFunction.hideLoadingIndicator()
                self.multiOptionAlertBox(title: appName, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: appName, message: responseDict["message"]! as! String)
            }
        }
    }
    func callDeleteService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.delete_product_qoutation, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: appName, message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    GlobalFunction.hideLoadingIndicator()
                    self.multiOptionAlertBox(title: appName, message: responseDict["message"] as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                    self.alertbox(title: appName, message: responseDict["message"] as! String)
                }
            }
        }
    }
    func callSubmitMultipalProduct(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.submit_multiple_product_for_pricing, params: params) { (responseDict, status) in
            if responseDict.isEmpty {
                self.alertbox(title: appName, message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    GlobalFunction.hideLoadingIndicator()
                    self.multiOptionAlertBox(title: appName, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                    self.alertbox(title: appName, message: responseDict["message"]! as! String)
                }
            }
        }
    }
    
    func callSubmitForPricing(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.submit_for_pricing, params: params) { (responseDict, status) in
            GlobalFunction.hideLoadingIndicator()
            if responseDict.isEmpty {
                self.alertbox(title: appName, message: Messages.noResponsefromServer)
            }else {
                if status == 200 {
                    self.multiOptionAlertBox(title: appName, message: responseDict["message"]! as! String, action1: "Ok") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alertbox(title: appName, message: responseDict["message"]! as! String)
                }
            }
        }
    }
}
