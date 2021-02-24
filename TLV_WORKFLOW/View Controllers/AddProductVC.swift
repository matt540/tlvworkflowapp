//
//  AddProductVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 03/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage

class AddProductVC: BaseViewController {
    
    
    @IBOutlet weak var lblNoImageAvailable: UILabel!
    @IBOutlet weak var uvNoImageAvailable: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    var isEditView: Bool = false
    var sellerId: Int?
    var productId: Int?
    
    //MARK: button outlets
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMaterial: UIButton!
    @IBOutlet weak var btnPetYes: UIButton!
    @IBOutlet weak var btnPetNo: UIButton!
    @IBOutlet weak var btnUploadProductImage: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    //MARK: txtfield outlets
    @IBOutlet weak var txtSellerName: UITextField!
    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtProductQuantity: UITextField!
    @IBOutlet weak var txtRetailPrice: UITextField!
    @IBOutlet weak var txtTlvPrice: UITextField!
    @IBOutlet weak var txtCommision: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtUnits: UITextField!
    @IBOutlet weak var txtWidth: UITextField!
    @IBOutlet weak var txtDepth: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtSeatHeight: UITextField!
    @IBOutlet weak var txtArmHeight: UITextField!
    @IBOutlet weak var txtShippingSize: UITextField!
    @IBOutlet weak var txtShippingCatagory: UITextField!
    @IBOutlet weak var txtProductDetail: UITextView!
    @IBOutlet weak var txtPackagingFee: UITextField!
    @IBOutlet weak var txtConditionNotes: UITextView!
    @IBOutlet weak var txtPickupLocation: UITextField!
    @IBOutlet weak var txtDelivery: UITextField!
    @IBOutlet weak var txtInternalNotes: UITextView!
    
    
    @IBOutlet weak var ageViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: uiview outlets
    @IBOutlet weak var ageView: UIView!
    
    //MARK: collection view outlets
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    
    var textFieldArray: [UITextField] = []
    var dropDownTextfieldArray: [UITextField] = []
    
    var sellerPicker = UIPickerView()
    var quantityPicker = UIPickerView()
    var shipingSizePicker = UIPickerView()
    var shipingCategoryPicker = UIPickerView()
    var pickupLocationPicker = UIPickerView()
    var deliveryLocationPicker = UIPickerView()
    var commissionPicker = UIPickerView()
    
    var data: AddProductModel?
    var sizeData : SizeModel?
    var pickupLocationData: PickUPLocationModel?
    var selectedData: [[AddProductSubcategory]] = [[],[],[],[],[],[],[]]
    var selectedDataSubCategory = [[AddProductChildren]]()
    var multipleData: [Bool] = [false,true,true,true,true,false,true]
    var headerData: [String] = ["Add Brand","Add Category","","Add Color","Add Condition","Add Age","Add Material"]
    
    var addImage: [AddProductProductPendingImage] = []
    var addImageIds: [Any] = []
    var imgArray = [#imageLiteral(resourceName: "user_icon"),#imageLiteral(resourceName: "logout")]
    let shippingCategory: [String] = ["SEATING","LIGHTING","STORAGE","RUGS","ART","ACCESSORIES","TABLES"]
    let deliveryOptions: [String] = ["Professional Delivery, quote upon request","Free Local Pickup, professional delivery available, quote upon request","Free Local Pickup, shipping available, quote upon request"]
    var imageArrayForCollection:[String] = []
    var pickUpLocationId : Int?
    var pickupLocationIndex: Int?
    var quantityIndex: Int?
    var sizeIndex: Int?
    var shippingCategoryIndex: Int?
    var selectedDelivery = ""
    var sellerDataOffline = ""
    var shipSizeDataList = [SizeData]()
    var editImageData = [EditImageStore]()
    let commissiondata = [40,50,60,70,80,100]
    var commissionIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = productDetailCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
            let size = CGSize(width:(productDetailCollectionView!.bounds.width-30)/2, height: 30.0)
            layout.itemSize = size
        }
        
        ageViewHeightConstraint.constant = 0.0
        dropDownTextfieldArray = [txtProductQuantity, txtPickupLocation, txtSellerName, txtShippingCatagory, txtShippingSize, txtDelivery, txtCommision]
        textFieldArray = [txtSellerName, txtPickupLocation, txtProductName, txtProductQuantity, txtTlvPrice, txtRetailPrice, txtCommision, txtUnits, txtDepth, txtWidth, txtHeight, txtShippingCatagory, txtPackagingFee, txtShippingSize, txtDelivery, txtSeatHeight, txtArmHeight]
        for textField in dropDownTextfieldArray{
            dropDownDesign(textField: textField)
        }
        for textField in textFieldArray{
            textFieldDesign(textField: textField)
        }
        txtConditionNotes.text = Constant.PlaceholderText.condition_notes
        txtProductDetail.text = Constant.PlaceholderText.diamention_product_detail
        txtInternalNotes.text = Constant.PlaceholderText.internal_notes
        txtInternalNotes.textColor = .lightGray
        txtConditionNotes.textColor = .lightGray
        txtProductDetail.textColor = .lightGray
        
        if isEditView {
            lblTitle.text = Constant.LableText.lbl_title_edit_product
            if GlobalFunction.isNetworkReachable(){
                var dictParam: [String : Any] = [:]
                dictParam[ Constant.ParameterNames.key ] = serviceKey
                dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
                dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
                dictParam[ Constant.ParameterNames.id] = productId
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    GlobalFunction.showLoadingIndicator()
                    self.getDataToEditSellerProduct(params: dictParam)
                }
            }else{
                offlineEditProduct()
                self.editImageData = DataInfo().retriveEditImageData(productId: self.productId!)
            }
        }else {
            lblTitle.text = Constant.LableText.lbl_title_add_product
            if !GlobalFunction.isNetworkReachable(){
                offlineDataAddProduct()
            }else{
                var dictParam: [String : Any] = [:]
                dictParam[ Constant.ParameterNames.key ] = serviceKey
                dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
                dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    GlobalFunction.showLoadingIndicator()
                    self.getDataToAddSellerProduct(params: dictParam)
                }
            }
            
        }
        
        setPicker(pickerView: sellerPicker, field: txtSellerName)
        setPicker(pickerView: quantityPicker, field: txtProductQuantity)
        setPicker(pickerView: shipingSizePicker, field: txtShippingSize)
        setPicker(pickerView: shipingCategoryPicker, field: txtShippingCatagory)
        setPicker(pickerView: pickupLocationPicker, field: txtPickupLocation)
        setPicker(pickerView: deliveryLocationPicker, field: txtDelivery)
        setPicker(pickerView: commissionPicker, field: txtCommision)
    }
}
//MARK: Button Actions
extension AddProductVC{
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
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMaterialAction(_ sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
    }
    
    @IBAction func btnPetAction(_ sender: UIButton) {
        if sender == btnPetYes{
//            btnPetYes.isSelected = btnPetYes.isSelected ? false : true
            btnPetYes.isSelected = true
            btnPetNo.isSelected = false
        }else {
//            btnPetNo.isSelected = btnPetNo.isSelected ? false : true
            btnPetYes.isSelected = false
            btnPetNo.isSelected = true 
        }
    }
    
    @IBAction func btnUploadImageAction(_ sender: UIButton) {
        CameraHandler.shared.imagePickedBlock = { (image) in
            if GlobalFunction.isNetworkReachable(){
                GlobalFunction.showLoadingIndicator()
                self.imageUpload(image: image)
            }else{
                if self.isEditView{
                    let data = image.pngData()
                    DataInfo().createEditImageData(productId: self.productId!, imageData: data!, status: 0)
                     self.editImageData = DataInfo().retriveEditImageData(productId: self.productId!)
                }else{
                    let pngData = image.jpegData(compressionQuality: 2.0)
                    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    let documentsPath = paths[0] //Get the docs directory
                    let timeStamp = Date().timeIntervalSince1970
                    let timeStampObj = NSNumber(value: timeStamp)
                    let ts = timeStampObj.intValue
                    let strPath = String(format: "%ld.png", ts)
                    let filePath = URL(fileURLWithPath: documentsPath.path).appendingPathComponent(strPath).path //Add the file name
                    if let pngData = pngData {
                        NSData(data: pngData).write(toFile: filePath, atomically: true)
                    }
                    self.addImageIds.append(strPath)
                }
                self.photoCollectionView.reloadData()
            }
        }
        CameraHandler.shared.showActionSheet(vc: self)
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if txtSellerName.text == "" {
            alertbox(title: Messages.tlv, message: Messages.selectSeller)
        }else if txtProductName.text == ""{
            alertbox(title: Messages.tlv, message: Messages.enterProductName)
        }else if txtProductQuantity.text == ""{
            alertbox(title:  Messages.tlv, message: Messages.enterProductQuantity)
        }else {
            var dictParam:[String : Any] = [:]
            var dictProductId:[String : Any] = [:]
            var dictProductParam: [String : Any] = [:]
            
            if self.isEditView {
                dictProductParam["seller_id"] = self.data?.data.product.productId.sellerid.id
            }else {
                dictProductParam["seller_id"] = self.sellerId
            }
            
            dictProductParam["name"] = self.txtProductName.text
            if self.txtShippingCatagory.text != ""{
                dictProductParam["ship_cat"] = (shippingCategory.firstIndex(of: self.txtShippingCatagory.text ?? "") ?? 0) + 1
            }
            dictProductParam["flat_rate_packaging_fee"] = self.txtPackagingFee.text
            dictProductParam["ship_material"] = self.btnMaterial.isSelected
            dictProductParam["ship_size"] = self.txtShippingSize.text
            dictProductParam["pick_up_location"] = pickUpLocationId
            //value for local_brand is not found in original project at line 2266
            dictProductParam["brand_local"] = ""
            dictProductParam["pet_free"] = btnPetYes.isSelected ? "yes" : btnPetNo.isSelected ? "no" : ""
            
            var brandArray:[Int] = []
            if selectedData[0].isEmpty {
                brandArray = []
            }else{
                for brand in selectedData[0]{
                    brandArray.append(brand.id)
                }
            }
            dictProductParam["brand"] = brandArray
            var categoryArray:[Int] = []
            if selectedData[1].isEmpty {
                categoryArray = []
            }else {
                for category in selectedData[1]{
                    categoryArray.append(category.id)
                }
            }
            var subCategoryArray:[Int] = []
            if selectedDataSubCategory.isEmpty {
                subCategoryArray = []
            }else {
                for containerSubCategory in selectedDataSubCategory{
                    for subCategory in containerSubCategory{
                        subCategoryArray.append(subCategory.id)
                    }
                }
            }
            dictProductParam["subcategories"] = categoryArray + subCategoryArray
            var colorArray:[Int] = []
            if selectedData[3].isEmpty {
                colorArray = []
            }else {
                for color in selectedData[3]{
                    colorArray.append(color.id)
                }
            }
            dictProductParam["color"] = colorArray
            var conditionArray:[Int] = []
            if selectedData[4].isEmpty {
                conditionArray = []
            }else {
                for condition in selectedData[4]{
                    conditionArray.append(condition.id)
                }
            }
            dictProductParam["condition"] = conditionArray
            var ageArray:[Int] = []
            if selectedData[5].isEmpty {
                ageArray = []
            }else {
                for age in selectedData[5]{
                    ageArray.append(age.id)
                }
            }
            dictProductParam["age"] = ageArray
            var materialArray:[Int] = []
            if selectedData[6].isEmpty {
                materialArray = []
            }else {
                for material in selectedData[6]{
                    materialArray.append(material.id)
                }
            }
            dictProductParam["product_materials"] = materialArray
            
            dictProductId["product_id"] = dictProductParam
            dictProductId["price"] = txtRetailPrice.text
            dictProductId["quantity"] = txtProductQuantity.text
            dictProductId["tlv_price"] = txtTlvPrice.text
            dictProductId["commission"] = txtCommision.text
            dictProductId["dimension_description"] = txtProductDetail.text == "Diamension/Product Details" ? "" : txtProductDetail.text
            dictProductId["condition_note"] = txtConditionNotes.text == "Condition Notes" ? "" : txtConditionNotes.text
            dictProductId["note"] = txtInternalNotes.text == "Internal Notes" ? "" : txtInternalNotes.text
            dictProductId["delivery_option"] = txtDelivery.text
            dictProductId["units"] = txtUnits.text
            dictProductId["width"] = txtWidth.text
            dictProductId["depth"] = txtDepth.text
            dictProductId["height"] = txtHeight.text
            dictProductId["arm_height"] = txtArmHeight.text
            dictProductId["seat_height"] = txtSeatHeight.text
            
            var imageArray:[Int] = []
            if self.isEditView{
                for image in self.data?.data.product.productId?.productPendingImages ?? []{
                    imageArray.append(image.id)
                }
            }else {
                for image in addImage{
                    imageArray.append(image.id)
                }
            }
            
            dictProductId["images"] = imageArray
            
            if self.isEditView{
                dictProductId["id"] = self.data?.data.product.id
            }
            dictParam["key"] = serviceKey
            dictParam["user_id"] = currentLoginUser.data.id
            dictParam["role_id"] = currentLoginUser.data.roles[0].id
            dictParam["product_quotation"] = dictProductId
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                GlobalFunction.showLoadingIndicator()
                self.saveProduct(params: dictParam)
            }
        }
    }
}

//MARK: textview delegate methods
extension AddProductVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == txtConditionNotes{
                textView.text = Constant.PlaceholderText.condition_notes
            }else if textView == txtProductDetail {
                textView.text = Constant.PlaceholderText.diamention_product_detail
            }else if textView == txtInternalNotes{
                textView.text = Constant.PlaceholderText.internal_notes
            }else {
                print(textView.nibName)
            }
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK:- Textfield delegate methods
extension AddProductVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDelivery{
            txtDelivery.resignFirstResponder()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.deliveryOptionVC) as! DeliveryOptionVC
            vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
            vc.deleveryOptions = deliveryOptions
            vc.deleveryCompletion = { (selectedString) in
                self.txtDelivery.text = selectedString
            }
            self.presentPopUp(vc)
            
        }
    }
}

//MARK: WebService Call
extension AddProductVC{
    func getDataToAddSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.add_seller_product_for_production_stage, params: params) { (responseDict, status) in
            if status == 200{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.data = AddProductModel(fromDictionary: responseDict as! [String : Any])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        //GlobalFunction.showLoadingIndicator()
                        self.getSize()
                    }
                }
                self.txtSellerName.isEnabled = true
                self.txtProductQuantity.isEnabled = true
                self.txtShippingSize.isEnabled = true
                self.txtShippingCatagory.isEnabled = true
                self.txtPickupLocation.isEnabled = true
                self.txtDelivery.isEnabled = true
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    func getDataToEditSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.edit_seller_product_for_production_stage, params: params) { (responseDict, status) in
            if status == 200{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.data = AddProductModel(fromDictionary: responseDict as! [String : Any])
                    self.imageDataAdd()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.getSize()
                    }
                }
                self.txtSellerName.isEnabled = false
                self.txtSellerName.backgroundColor =  UIColor(red: 222.0 / 255, green: 222.0 / 255, blue: 222.0 / 255, alpha: 1.0)
                self.txtProductQuantity.isEnabled = true
                self.txtShippingSize.isEnabled = true
                self.txtShippingCatagory.isEnabled = true
                self.txtPickupLocation.isEnabled = true
                self.txtDelivery.isEnabled = true
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    func getSize(){
        WebAPIManager.makeAPIRequest(method: .get, isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_size, params: [:]) { (responseDict, status) in
            
            let data = responseDict[ Constant.ParameterNames.data ] as? NSArray
            var dict:[[String : Any]] = []
            for size in data ?? [] {
                dict.append(size as! [String : Any])
            }
            let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
            self.sizeData = SizeModel(fromDictionary: parentDict)
            self.shipSizeDataList = self.sizeData!.data
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                var dictParam: [String : Any] = [:]
                dictParam[Constant.ParameterNames.key] = serviceKey
                dictParam[Constant.ParameterNames.seller_id] = self.sellerId
                //GlobalFunction.showLoadingIndicator()
                self.getPickupLocation(params: dictParam)
            }
            self.setData()
            self.productDetailCollectionView.reloadData()
        }
    }
    
    func getPickupLocation(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_pickup_location, params: params) { (responseDict, status) in
            
            if status == 200{
                let data = responseDict[Constant.ParameterNames.data] as! NSArray
                var dict:[[String : Any]] = []
                for size in data {
                    dict.append(size as! [String : Any])
                }
                var dictExtra: [String : Any] = [:]
                dictExtra["value_text"] = "ADD LOCATION"
                dict.insert(dictExtra, at: 0)
                self.pickupLocationPicker.reloadAllComponents()
                let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
                self.pickupLocationData = PickUPLocationModel(fromDictionary: parentDict)
                if self.pickupLocationIndex == nil{
                    self.pickupLocationPicker.selectRow(0, inComponent: 0, animated: true)
                }else{
                    self.pickupLocationPicker.reloadAllComponents()
                    self.pickupLocationPicker.selectRow(self.pickupLocationIndex! + 1, inComponent: 0, animated: true)
                }
            }else{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    func getPickupLocationWithId(params: [String : Any], pickupId: Int){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_pickup_location, params: params) { (responseDict, status) in
            if status == 200{
                let data = responseDict[Constant.ParameterNames.data] as! NSArray
                var dict:[[String : Any]] = []
                for size in data {
                    dict.append(size as! [String : Any])
                }
                var dictExtra: [String : Any] = [:]
                dictExtra["value_text"] = "ADD LOCATION"
                dict.insert(dictExtra, at: 0)
                
                let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
                self.pickupLocationData = PickUPLocationModel(fromDictionary: parentDict)
                self.pickupLocationPicker.reloadAllComponents()
                
                for i in 1..<self.pickupLocationData!.data.count{
                    let strId1 = self.pickupLocationData?.data[i].id
                    if strId1 == pickupId{
                        if self.pickupLocationData?.data[i].keyText == []{
                            self.txtPickupLocation.text = self.pickupLocationData?.data[i].valueText
                        }else{
                            self.txtPickupLocation.text = "\(self.pickupLocationData?.data[i].keyText[0].city ?? ""), \(self.pickupLocationData?.data[i].keyText[0].state ?? "")"
                            self.pickupLocationPicker.selectRow(i, inComponent: 0, animated: true)
                        }
                    }
                }
            }else{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    func callDeleteImage(params: [String : Any], id : Int) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.delete_product_image, params: params) { (responseDict, status) in
            if status == 200{
                GlobalFunction.hideLoadingIndicator()
                self.multiOptionAlertBox(title: Messages.success, message: Messages.imageRemoved, action1: "Ok") { (_ ) in
                    //model of pending images is filtered for refresh collection locally
                    if self.isEditView{
                        self.data?.data.product.productId?.productPendingImages = self.data?.data.product.productId?.productPendingImages.filter{ $0.id != id }
                        self.imageDataAdd()
                    }else {
                        self.addImage = self.addImage.filter{ $0.id != id }
                    }
                    self.photoCollectionView.reloadData()
                }
            }else {
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: responseDict[ Constant.ParameterNames.status ] as! String, message: Messages.errorOccur )
            }
        }
    }
    
    func imageUpload(image: UIImage) {
        let image = image
        let imagesData = ["photo": [GlobalFunction.resizeImage(image: image)]]
        var params:[String:String] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.folder] = Constant.FolderNames.product
        WebAPIManager.makeMultipartRequestToUploadImages(isFormDataRequest: true, isContainXAPIToken: true, isContainContentType: true, path: Constant.Api.upload_product_image, parameters: params, imagesData: [imagesData]) { (responseDict, status) in
            if responseDict["code"] as! Int == 200{
                GlobalFunction.hideLoadingIndicator()
                let imgResponse = responseDict[ Constant.ParameterNames.data ] as? [String:Any]
                let img = AddProductProductPendingImage(fromDictionary: imgResponse ?? [:])
                if self.isEditView{
                    self.data?.data.product.productId?.productPendingImages.append(img)
                    if DataInfo().isProductDataDetailExists(productId: self.productId!){
                        DataInfo().createEditImageData(productId: self.productId!, imageData: image.pngData()!, status: 0)
                    }
                }else {
                    self.addImage.append(img)
                }
                
                self.photoCollectionView.reloadData()
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: Messages.error, message: responseDict["message"] as? String ?? Messages.error)
            }
        }
    }
    
    func saveProduct(params : [String : Any]) {
        if GlobalFunction.isNetworkReachable(){
            WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.save_product_for_productions, params: params) { (responseDict, status) in
                if status == 200{
                    DataInfo().updateEditImageDataStatus()
                    if self.isEditView{
                        if DataInfo().isProductDataDetailExists(productId: self.productId!){
                            var dict = [String:Any]()
                            dict["id"] = self.productId
                             NotificationCenter.default.post(name: .editProductSave, object: nil,userInfo: dict)
                        }
                    }
                    GlobalFunction.hideLoadingIndicator()
                    self.multiOptionAlertBox(title: appName, message: responseDict[Constant.ParameterNames.status] as! String, action1: "OK") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                    self.alertbox(title: "\(status)", message: responseDict[Constant.ParameterNames.status] as! String)
                }
            }
        }else {
            let JsonData = try?JSONSerialization.data(withJSONObject: params, options: [])
            let jsonString = String(data: JsonData!, encoding: .utf8)!
            if isEditView{
                DataInfo().updateEditImageDataStatus()
                if DataInfo().isEditProductDataExists(productId: productId!){
                    DataInfo().updateEditProductData(id: productId!, productData: jsonString)
                }else{
                    DataInfo().createEditProductData(productId: productId!, productData: jsonString)
                }
                GlobalFunction.hideLoadingIndicator()
                if jsonString != ""{
                    self.multiOptionAlertBox(title: appName, message: Messages.productAddSuccessfully, action1: "OK") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }else{
                DataInfo().createAddProductData(product_detail: jsonString)
                for image in addImageIds{
                    DataInfo().createImageData(image_url: image as! String)
                }
                GlobalFunction.hideLoadingIndicator()
                if jsonString != ""{
                    self.multiOptionAlertBox(title: appName, message: Messages.productAddSuccessfully, action1: "OK") { (_ ) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func imageDataAdd() {
        if DataInfo().isProductDataDetailExists(productId: productId!){
            if self.data?.data.product.productId?.productPendingImages.count ?? 0 > 0{
                DataInfo().deleteEditImageDataId(id: productId!)
                for i in (self.data?.data.product.productId!.productPendingImages)!{
                    let data = (try? Data(contentsOf: URL(string: image_base_url + i.name)!))!
                    DataInfo().createEditImageData(productId: productId!, imageData: data, status: 1)
                }
            }else if self.data?.data.product.productId?.productPendingImages.count ?? 0 == 0{
                DataInfo().deleteEditImageDataId(id: productId!)
            }
        }
    }
}

//MARK:- Oflline Data
extension AddProductVC{
    func offlineDataAddProduct(){
        self.txtSellerName.isEnabled = true
        self.txtProductQuantity.isEnabled = true
        self.txtShippingSize.isEnabled = true
        self.txtShippingCatagory.isEnabled = true
        self.txtPickupLocation.isEnabled = true
        self.txtDelivery.isEnabled = true
        
        let dataShopData = DataInfo().retriveDataShop()
        if dataShopData.count > 0{
            let sellerDataDic = GlobalFunction.convertToDictionary(text: dataShopData[0].seller_data ?? "")
            self.data = AddProductModel(fromDictionary: sellerDataDic ?? [:])
            offlineSizeData()
            offlinePickupLocation(pickUpLocation: dataShopData[0].pick_location ?? "")
            
        }else{
            UIApplication.shared.windows.first?.makeToast("Please connect internet.")
        }
    }
    
    func offlineEditProduct(){
        self.txtSellerName.isUserInteractionEnabled = false
        self.txtSellerName.backgroundColor =  UIColor(red: 222.0 / 255, green: 222.0 / 255, blue: 222.0 / 255, alpha: 1.0)
        let editProductData = DataInfo().retriveProductDataDetails()
        if editProductData.count > 0{
            for i in editProductData{
                if Int(i.product_id) == productId{
                    let productDataDic = GlobalFunction.convertToDictionary(text: i.product_data ?? "")
                    self.data = AddProductModel(fromDictionary: productDataDic ?? [:])
                    offlineSizeData()
                    let dataShopData = DataInfo().retriveDataShop()
                    if dataShopData.count > 0{
                    offlinePickupLocation(pickUpLocation: dataShopData[0].pick_location ?? "")
                    }
                }
            }
        }
    }
    
    func offlineSizeData() {
        let shipSizeData = DataInfo().retriveDataShipSize()
        if shipSizeData.count > 0{
            let shipSizeArray = shipSizeData[0].shipsize?.components(separatedBy: "}-")
            var shipSizeDic: [String : Any] = [:]
            for i in 0..<shipSizeArray!.count{
                if i == shipSizeArray!.count - 1{
                    shipSizeDic = GlobalFunction.convertToDictionary(text: shipSizeArray?[i] ?? "") ?? [:]
                }else{
                    shipSizeDic = GlobalFunction.convertToDictionary(text: shipSizeArray![i] + "}" ) ?? [:]
                }
                let shipSizeList = SizeData(fromDictionary: shipSizeDic)
                self.shipSizeDataList.append(shipSizeList)
            }
            self.setData()
            self.productDetailCollectionView.reloadData()
        }else{
            UIApplication.shared.windows.first?.makeToast("Please connect internet.")
        }
    }
    
    func offlinePickupLocation(pickUpLocation: String) {
        let pickuplocationDic = GlobalFunction.convertToDictionary(text: pickUpLocation)
        let data = pickuplocationDic?[Constant.ParameterNames.data] as! NSArray
        var dict:[[String : Any]] = []
        for size in data {
            dict.append(size as! [String : Any])
        }
        let parentDict1:[String : Any] = [Constant.ParameterNames.data:dict]
        self.pickupLocationData = PickUPLocationModel(fromDictionary: parentDict1)
        
        var dictExtra: [String : Any] = [:]
        dictExtra["value_text"] = "Sellers Home"
        dict.insert(dictExtra, at: 0)
        self.pickupLocationPicker.reloadAllComponents()
        let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
        self.pickupLocationData = PickUPLocationModel(fromDictionary: parentDict)
        if self.pickupLocationIndex == nil{
            self.pickupLocationPicker.selectRow(0, inComponent: 0, animated: true)
        }else{
            self.pickupLocationPicker.reloadAllComponents()
            self.pickupLocationPicker.selectRow(self.pickupLocationIndex! + 1, inComponent: 0, animated: true)
        }
    }
}

//MARK: Set data when load
extension AddProductVC{
    func setData()
    {
        if isEditView{
            let productData = data?.data.product
            let sellerData = data?.data.sellers.filter{ $0.id == sellerId }
            txtSellerName.text = sellerData![0].displayname
            txtProductName.text = productData?.productId.name
            txtProductQuantity.text = productData?.productId.quantity
            quantityIndex = (Int(productData?.productId.quantity ?? "1") ?? 1) - 1
            self.quantityPicker.reloadAllComponents()
            self.quantityPicker.selectRow(quantityIndex ?? 0, inComponent: 0, animated: true)
            txtRetailPrice.text = productData?.productId.price
            txtTlvPrice.text = productData?.productId.tlvPrice
            txtUnits.text = productData?.units
            txtWidth.text = productData?.width
            txtDepth.text = productData?.depth
            txtHeight.text = productData?.height
            txtSeatHeight.text = productData?.seatHeight
            txtArmHeight.text = productData?.armHeight
            txtShippingSize.text = productData?.productId.shipSize
            
            if productData?.commission != ""{
                txtCommision.text = productData?.commission
                for i in 0..<commissiondata.count{
                    if commissiondata[i] == Int((productData?.commission)!){
                        commissionIndex = i
                    }
                }
                self.commissionPicker.reloadAllComponents()
                self.commissionPicker.selectRow(commissionIndex ?? 0, inComponent: 0, animated: true)
            }
            if productData?.productId.shipSize != ""{
                for i in 0..<shipSizeDataList.count{
                    if shipSizeDataList[i].keyText == productData?.productId.shipSize{
                        sizeIndex = i
                    }
                }
                self.shipingSizePicker.reloadAllComponents()
                self.shipingSizePicker.selectRow(sizeIndex ?? 0, inComponent: 0, animated: true)
            }
            
            if productData?.productId.brand != nil{
                if productData?.productId.brand.subCategoryName != "" && productData?.productId.brand.subCategoryName != nil{
                    var brand: [AddProductSubcategory]?
                    for category in (self.data?.data.categories)!{
                        if category.categoryName == "Brand"{
                            brand = category.subcategories.filter{$0.subCategoryName == productData?.productId.brand?.subCategoryName }
                        }
                    }
                    selectedData[0] = [brand![0]]
                    selectedData[0][0].isCategorySelected = true
                }
            }
            
            if productData?.productId.productCategory.count != 0{
                for category in (productData?.productId.productCategory)!{
                    for subCategory in (self.data?.data.categories[1].subcategories)!{
                        if subCategory.id == category.id{
                            selectedData[1].append(subCategory)
                        }
                    }
                }
                
                for i in selectedData[1]{
                    i.isCategorySelected = true
                }
                
                let ids = selectedData[1].map { $0.id }
                
                let subcategoryData = productData?.productId.productCategory.filter{
                    if !ids.contains($0.id){
                        return true
                    }
                    return false
                }
                
                var subCat = data?.data.categories[1].subcategories
                subCat = subCat?.filter { $0.isEnable == 1 }
                
                var subCategorySelectedData1 = [AddProductChildren]()
                for i in 0..<subcategoryData!.count{
                    for j in 0..<subCat!.count{
                        for k in 0..<subCat![j].childrens.count{
                            if subCat![j].childrens[k].id == subcategoryData![i].id {
                                subCategorySelectedData1.append(subCat![j].childrens[k])
                            }
                        }
                    }
                }
                for i in subCategorySelectedData1{
                    i.isCategorySelected = true
                }
                let collectionIdsSet = Set(subCategorySelectedData1.map { $0.parentId.id })
                let collectionIds = Array(collectionIdsSet)
                for i in collectionIds{
                    let subData = subCategorySelectedData1.filter{ $0.parentId.id ==  i }
                    if subData.count > 0 {
                        selectedDataSubCategory.append(subData)
                    }
                }
            }
            if !(productData?.productId.productColor.isEmpty)!{
                var colorData = [AddProductSubcategory]()
                
                for color in (productData?.productId.productColor)!{
                    selectedData[3].append(color)
                    for category in (self.data?.data.categories)!{
                        if category.categoryName == "Color"{
                            colorData.append(category.subcategories.filter{$0.subCategoryName == color.subCategoryName }[0])
                        }
                    }
                }
                for i in colorData{
                    i.isCategorySelected = true
                }
            }
            if !(productData?.productId.productCon.isEmpty)!{
                var conditionData = [AddProductSubcategory]()
                for condition in (productData?.productId.productCon)!{
                    selectedData[4].append(condition)
                    for category in (self.data?.data.categories)!{
                        if category.categoryName == "Condition"{
                            conditionData.append(category.subcategories.filter{$0.subCategoryName == condition.subCategoryName }[0])
                        }
                    }
                }
                for i in conditionData{
                    i.isCategorySelected = true
                }
            }
            if productData?.productId.age?.subCategoryName != "" && productData?.productId.age?.subCategoryName != nil {
                var age: [AddProductSubcategory]?
                for category in (self.data?.data.categories)!{
                    if category.categoryName == "Age"{
                        age = category.subcategories.filter{$0.subCategoryName == productData?.productId.age?.subCategoryName }
                    }
                }
                selectedData[5] = [age![0]]
                selectedData[5][0].isCategorySelected = true
            }
            if !(productData?.productId.productMaterials.isEmpty)!{
                var materialData = [AddProductSubcategory]()
                for material in (productData?.productId.productMaterials)!{
                    selectedData[6].append(material)
                    for category in (self.data?.data.categories)!{
                        if category.categoryName == "Materials"{
                            materialData.append(category.subcategories.filter{$0.subCategoryName == material.subCategoryName }[0])
                        }
                    }
                }
                for i in materialData{
                    i.isCategorySelected = true
                }
            }
            
            if productData?.productId.shipCat != ""{
                txtShippingCatagory.text = shippingCategory[ Int((productData?.productId.shipCat)!)! - 1 ]
                self.shipingCategoryPicker.reloadAllComponents()
                self.shipingCategoryPicker.selectRow(Int((productData?.productId.shipCat)!)! - 1, inComponent: 0, animated: true)
            }
            if productData?.dimensionDescription != ""{
                txtProductDetail.text = productData?.dimensionDescription
                txtProductDetail.textColor = UIColor.black
            }else {
                txtProductDetail.text = Constant.PlaceholderText.diamention_product_detail
                txtProductDetail.textColor = UIColor.lightGray
            }
            if productData?.conditionNote != ""{
                txtConditionNotes.text = productData?.conditionNote
                txtConditionNotes.textColor = UIColor.black
            }else {
                txtConditionNotes.text = Constant.PlaceholderText.condition_notes
                txtConditionNotes.textColor = UIColor.lightGray
            }
            if productData?.note != ""{
                txtInternalNotes.text = productData?.note
                txtInternalNotes.textColor = UIColor.black
            }else {
                txtInternalNotes.text = Constant.PlaceholderText.internal_notes
                txtInternalNotes.textColor = UIColor.lightGray
            }
            txtPackagingFee.text = productData?.productId.flatRatePackagingFee
            
            if !(self.data?.data.pickupLocations.isEmpty)! && productData?.productId.pickUpLocation != nil{
                for i in 0..<self.data!.data.pickupLocations.count{
                    if self.data?.data.pickupLocations[i].id == productData?.productId.pickUpLocation.id{
                        pickupLocationIndex = i
                        if self.data!.data.pickupLocations[i].keyText == []{
                            txtPickupLocation.text = self.data!.data.pickupLocations[i].valueText
                        }else{
                            txtPickupLocation.text =  "\(self.data!.data.pickupLocations[i].keyText[0].city ?? ""), \(self.data!.data.pickupLocations[i].keyText[0].state ?? "")"
                        }
                    }
                }
            }
            if pickupLocationIndex == nil{
                self.pickupLocationPicker.selectRow(0, inComponent: 0, animated: true)
            }else{
                self.pickupLocationPicker.reloadAllComponents()
                self.pickupLocationPicker.selectRow(self.pickupLocationIndex! + 1, inComponent: 0, animated: true)
                //        self.pickupLocationPicker.reloadComponent(0)
            }
            txtDelivery.text = productData?.deliveryOption
            btnMaterial.isSelected = productData?.productId.shipMaterial ?? false
            btnPetYes.isSelected = productData?.productId.petFree == "yes" ?  true : false
            btnPetNo.isSelected = productData?.productId.petFree == "no" ? true : false
            photoCollectionView.reloadData()
            GlobalFunction.hideLoadingIndicator()
        }else{
            let seller = data?.data.sellers.filter{ $0.id == sellerId}
            txtSellerName.text = seller?[0].displayname
            for i in 0..<data!.data.sellers.count{
                if data!.data.sellers[i].id == sellerId{
                    sizeIndex = i
                }
            }
            self.sellerPicker.reloadAllComponents()
            self.sellerPicker.selectRow(sizeIndex ?? 0, inComponent: 0, animated: true)
            txtProductQuantity.text = "1"
            btnPetYes.isSelected = true
            GlobalFunction.hideLoadingIndicator()
        }
    }
}

//MARK: Collection View Delegate methods
extension AddProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productDetailCollectionView{
            let numberOfCell = data?.data.categories.count
            return numberOfCell ?? 0
        }else {
            if self.isEditView{
                if GlobalFunction.isNetworkReachable(){
                    return self.data?.data.product.productId?.productPendingImages.count ?? 0
                }else{
                    return editImageData.count
                }
            }else {
                if GlobalFunction.isNetworkReachable(){
                    return self.addImage.count
                }else{
                    return self.addImageIds.count
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productDetailCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.addProductDetailCell, for: indexPath as IndexPath) as! AddProductDetailCell
            let category = data?.data.categories[indexPath.row]
            cell.txtFieldName.placeholder = category?.categoryName
            if indexPath.row == 2{
                if selectedDataSubCategory.count > 1{
                    var tempArr: [String] = []
                    for i in 0..<selectedDataSubCategory.count{
                        let nameArr = selectedDataSubCategory[i].map{$0.subCategoryName}
                        let name = nameArr.compactMap{$0}.joined(separator: ",")
                        tempArr.append(name)
                    }
                    var finalName = tempArr.compactMap{$0}.joined(separator: ",")
                    finalName.removeLast()
                    cell.txtFieldName.text = finalName
                }else if selectedDataSubCategory.count == 1{
                    if selectedDataSubCategory[0].count > 1{
                        let nameArr = selectedDataSubCategory[0].map{$0.subCategoryName}
                        let name = nameArr.compactMap{$0}.joined(separator: ",")
                        cell.txtFieldName.text = name
                    }else if selectedDataSubCategory[0].count == 1{
                        cell.txtFieldName.text = selectedDataSubCategory[0][0].subCategoryName
                    }else{
                        cell.txtFieldName.text = ""
                    }
                }else{
                    cell.txtFieldName.text = ""
                }
            }else{
                if (selectedData[indexPath.row].count) > 0{
                    if (selectedData[indexPath.row].count) > 1{
                        let nameArr = selectedData[indexPath.row].map{$0.subCategoryName}
                        let name = nameArr.compactMap{$0}.joined(separator: ",")
                        cell.txtFieldName.text = name
                    }else if selectedData[indexPath.row].count == 1{
                        cell.txtFieldName.text = selectedData[indexPath.row][0].subCategoryName
                    }else{
                        cell.txtFieldName.text = ""
                    }
                }
            }
            cell.contentView.layer.cornerRadius = 5.0
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 1.0
            cell.layer.masksToBounds = false
            return cell
        }else {
            let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.addDataPictureCell, for: indexPath as IndexPath) as! AddDataPictureCell
            if GlobalFunction.isNetworkReachable(){
                var images: [AddProductProductPendingImage] = []
                if self.isEditView {
                    images = data?.data.product.productId.productPendingImages ?? []
                }else {
                    images = self.addImage
                }
                let imgUrl = image_base_url + (images[indexPath.row].name)!
                pictureCell.imageView!.sd_setImage(with: URL(string: imgUrl), completed: nil)
                pictureCell.deleteClosure = {
                    self.multiOptionAlertBox(title: Messages.tlv, message: Messages.confirmDeleteImage, action1: "Yes",action2: "No") { (actionStatus) in
                        if actionStatus == 0{
                            var paramDict: [String : Any] = [:]
                            paramDict[ Constant.ParameterNames.key ] = serviceKey
                            paramDict[ Constant.ParameterNames.folder ] = Constant.FolderNames.product
                            paramDict[ Constant.ParameterNames.name ] = images[indexPath.row].name
                            paramDict[ Constant.ParameterNames.id ] = images[indexPath.row].id
                            GlobalFunction.showLoadingIndicator()
                            self.callDeleteImage(params: paramDict, id: (images[indexPath.row].id)! )
                        }
                    }
                }
            }else {
                if isEditView{
                    let image = UIImage(data: editImageData[indexPath.row].imagedata!)
                    pictureCell.imageView!.image = image
                    pictureCell.deleteClosure = {
                        self.multiOptionAlertBox(title: Messages.tlv, message: Messages.confirmDeleteImage, action1: "Yes",action2: "No") { (actionStatus) in
                            if actionStatus == 0{
                                DataInfo().deleteEditImageData(imageData: self.editImageData[indexPath.row].imagedata!)
                                self.editImageData = DataInfo().retriveEditImageData(productId: self.productId!)
                                self.photoCollectionView.reloadData()
                            }
                        }
                    }
                }else{
                    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    let documentsDirectory = paths[0]
                    var writableDBPath: String? = nil
                    writableDBPath = URL(fileURLWithPath: documentsDirectory.path).appendingPathComponent(addImageIds[indexPath.item] as! String).path
                    let pngData = NSData(contentsOfFile: writableDBPath ?? "") as Data?
                    var image: UIImage? = nil
                    if let pngData = pngData {
                        image = UIImage(data: pngData)
                    }
                    pictureCell.imageView!.image = image
                    pictureCell.deleteClosure = {
                        self.multiOptionAlertBox(title: Messages.tlv, message: Messages.confirmDeleteImage, action1: "Yes",action2: "No") { (actionStatus) in
                            if actionStatus == 0{
                                DataInfo().deleteImageData(image_url: self.addImageIds[indexPath.row] as! String)
                                self.addImageIds = self.addImageIds.filter{ $0 as! String != self.addImageIds[indexPath.row] as! String}
                                self.photoCollectionView.reloadData()
                            }
                        }
                    }
                }
            }
            uvNoImageAvailable.backgroundColor = .clear
            uvNoImageAvailable.isHidden = true
            lblNoImageAvailable.isHidden = true
            return pictureCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productDetailCollectionView{
            if indexPath.row == 2{
                subCategoryDropDown(collectionView: collectionView, status: indexPath.row)
            }else{
                dropdownMenu(header: headerData[indexPath.row],multiple: multipleData[indexPath.row],index: indexPath.row,collectionView: collectionView)
            }
        }else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.photoVc) as! PhotoVC
            if isEditView{
                vc.isEditView = true
                if GlobalFunction.isNetworkReachable(){
                    vc.imgUrls = data?.data.product.productId.productPendingImages
                }else{
                    vc.editImageData = self.editImageData
                }
            }else{
                if GlobalFunction.isNetworkReachable(){
                    vc.imgUrls = self.addImage
                }else{
                    vc.addImageData = self.addImageIds
                }
            }
            self.presentPopUp(vc)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productDetailCollectionView {
            return CGSize(width: ((productDetailCollectionView.frame.size.width) / 2) - 10 , height: 35)
        } else {
            return CGSize(width: 80, height: 80)
        }
    }
    
}

//MARK:- CollectionView Dropdown Methods
extension AddProductVC {
    func dropdownMenu(header: String, multiple: Bool,index: Int,collectionView: UICollectionView){
        var subCategory = data?.data.categories[index].subcategories
        subCategory = subCategory?.filter { $0.isEnable == 1 }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.collectionViewDropDownVC) as! CollectionViewDropDownVC
        vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
        vc.lblHeader.text = header
        vc.isMultiple = multiple
        vc.subCategory = subCategory!
        vc.category = index
        vc.brandCompletion = {
            (list,status) in
            self.selectedData[index] = list
            
            if status == 1 {
                // if select data in category collection(subcategory) not changed for this use bellow comment function
                //self.allData(subCategory: subCategory!)
                self.removeData(collectionView: collectionView, subCategory: subCategory!)
            }
            if list.count > 1{
                let nameArr = list.map{$0.subCategoryName}
                let name = nameArr.compactMap{$0}.joined(separator: ",")
                self.dataSetIntoCell(collectionView: collectionView, name: name, status: status)
            }else if list.count == 1{
                self.dataSetIntoCell(collectionView: collectionView, name: list[0].subCategoryName, status: status)
            }else{
                self.dataSetIntoCell(collectionView: collectionView, name: "", status: status)
            }
        }
        self.presentPopUp(vc)
    }
    
    //MARK:- SubCategory DropDown
    func subCategoryDropDown(collectionView: UICollectionView, status: Int){
        let subCategory = selectedData[1]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.subCategoryVC) as! SubCategoryVC
        vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 160 )
        vc.subCategory = subCategory
        vc.lblHeader.text = ""
        vc.subCategoryCompletion = { (list) in
            self.selectedDataSubCategory = list
            if list.count > 1{
                var tempArr: [String] = []
                for i in 0..<list.count{
                    let nameArr = list[i].map{$0.subCategoryName}
                    let name = nameArr.compactMap{$0}.joined(separator: ",")
                    tempArr.append(name)
                }
                var finalName = tempArr.compactMap{$0}.joined(separator: ",")
                finalName.removeLast()
                self.dataSetIntoCell(collectionView: collectionView, name: finalName, status: status)
            }else if list.count == 1{
                let nameArr = list[0].map{$0.subCategoryName}
                let name = nameArr.compactMap{$0}.joined(separator: ",")
                self.dataSetIntoCell(collectionView: collectionView, name: name, status: status)
            }else{
                self.dataSetIntoCell(collectionView: collectionView, name: "", status: status)
            }
        }
        self.presentPopUp(vc)
    }
    
    //MARK:- Data Set into textfield
    func dataSetIntoCell(collectionView: UICollectionView, name: String, status: Int){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.addProductDetailCell, for: IndexPath(item: status, section: 0)) as! AddProductDetailCell
        cell.txtFieldName.text = name
        collectionView.reloadItems(at: [IndexPath(item: status, section: 0)])
    }
    
    //MARK:- function for subcategory all data
    func allData(subCategory: [AddProductSubcategory]){
        for i in subCategory{
            if self.selectedData[1].contains(i){
                
            }else{
                for j in i.childrens{
                    j.isCategorySelected = false
                }
            }
        }
    }
    
    //MARK:- function for remove all data
    func removeData(collectionView:UICollectionView, subCategory: [AddProductSubcategory]){
        for i in subCategory{
            for j in i.childrens{
                j.isCategorySelected = false
            }
        }
        selectedDataSubCategory = []
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.addProductDetailCell, for: IndexPath(item: 2, section: 0)) as! AddProductDetailCell
        cell.txtFieldName.text = ""
        collectionView.reloadItems(at: [IndexPath(item: 2, section: 0)])
    }
}
//MARK: Picker View Delegate methods
extension AddProductVC: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sellerPicker{
            return (data?.data.sellers.count)!
        }else if pickerView == quantityPicker{
            return 30
        }else if pickerView == shipingSizePicker {
            return shipSizeDataList.count
        }else if pickerView == shipingCategoryPicker {
            return shippingCategory.count
        }else if pickerView == pickupLocationPicker {
            return self.pickupLocationData?.data.count ?? 0
        }else if pickerView == deliveryLocationPicker {
            return 0
        }else if pickerView == commissionPicker{
            return commissiondata.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sellerPicker{
            return data?.data.sellers[row].displayname
        }else if pickerView == quantityPicker{
            return "\(row + 1)"
        }else if pickerView == shipingSizePicker {
            return shipSizeDataList[row].valueText
        }else if pickerView == shipingCategoryPicker {
            return shippingCategory[row]
        }else if pickerView == pickupLocationPicker {
            if row == 0 {
                return self.pickupLocationData?.data[row].valueText
            }else{
                if self.pickupLocationData?.data[row].keyText == []{
                    return self.pickupLocationData?.data[row].valueText
                }else{
                    return "\(self.pickupLocationData?.data[row].keyText[0].city ?? ""), \(self.pickupLocationData?.data[row].keyText[0].state ?? "")"
                }
            }
        }else if pickerView == commissionPicker{
            return "\(commissiondata[row])"
        }else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sellerPicker{
            let sellerData = data?.data.sellers[row]
            sellerId = sellerData?.id
            txtSellerName.text = sellerData?.displayname
        }else if pickerView == quantityPicker{
            txtProductQuantity.text = "\(row + 1)"
        }else if pickerView == shipingSizePicker{
            txtShippingSize.text = shipSizeDataList[row].valueText
        }else if pickerView == shipingCategoryPicker{
            txtShippingCatagory.text = shippingCategory[row]
        }else if pickerView == pickupLocationPicker{
            if row == 0 {
                txtPickupLocation.text = ""
            }else{
                if self.pickupLocationData?.data[row].keyText == []{
                    txtPickupLocation.text = self.pickupLocationData?.data[row].valueText
                    pickUpLocationId = self.pickupLocationData?.data[row].id
                }else{
                    txtPickupLocation.text =  "\(self.pickupLocationData?.data[row].keyText[0].city ?? ""), \(self.pickupLocationData?.data[row].keyText[0].state ?? "")"
                    pickUpLocationId = self.pickupLocationData?.data[row].id
                    //self.pickupLocationPicker.selectRow(row, inComponent: 0, animated: true)
                }
            }
        }else if pickerView == commissionPicker{
            self.txtCommision.text = "\(commissiondata[row])"
        }else {
            
        }
    }
    
}

//MARK: UIDesign Method
extension AddProductVC{
    func textFieldDesign(textField: UITextField) {
        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: txtProductName.frame.size.height))
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.leftView = viewPadding
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5.0
        textField.layer.shadowColor = UIColor.lightGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 3, height: 3)
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 1.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtProductName{
            self.txtProductName.resignFirstResponder()
        }else if textField == txtCommision{
            self.txtCommision.resignFirstResponder()
        }else if textField == txtProductDetail{
            self.txtProductDetail.resignFirstResponder()
        }else if textField == txtConditionNotes{
            self.txtConditionNotes.resignFirstResponder()
        }else if textField == txtInternalNotes{
            self.txtInternalNotes.resignFirstResponder()
        }else{
        }
        return true
    }
  
    func dropDownDesign(textField: UITextField) {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        imageView.image = UIImage(named: "Dropdown")
        imageView.contentMode = .center
        rightView.addSubview(imageView)
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.tintColor = .clear
    }
    
    func setPicker(pickerView: UIPickerView, field: UITextField) {
        pickerView.isUserInteractionEnabled = true
        pickerView.delegate = self
        pickerView.dataSource = self
        field.isEnabled = true
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let doneBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(yourTextViewDoneButtonPressed))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        field.inputAccessoryView = keyboardToolbar
        field.inputView = pickerView
        
    }
    
    @objc func yourTextViewDoneButtonPressed(){
        if(txtPickupLocation.isFirstResponder){
            let selectedValue = pickupLocationPicker.selectedRow(inComponent: 0)
            self.view.endEditing(true)
            if selectedValue == 0{
                if GlobalFunction.isNetworkReachable(){
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.addPickUpLocationVC) as! AddPickUpLocationVC
                    vc.view.frame = CGRect(x:0, y:0, width: self.view.frame.width - 40, height: self.view.frame.height - 375 )
                    vc.sellerId = sellerId
                    vc.AddLocationCompletion = { (pickupId) in
                        print(pickupId)
                        var params:[String:Any] = [:]
                        params[Constant.ParameterNames.key] = serviceKey
                        params[Constant.ParameterNames.seller_id] = self.sellerId
                        self.getPickupLocationWithId(params: params, pickupId: pickupId)                }
                    self.presentPopUp(vc)
                }else{
                    self.alertbox(title: Messages.tlv, message: Messages.pickuplocationNotAvailable)
                }
            }
        }else{
            self.view.endEditing(true)
        }
    }
}

