//
//  AddProductVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 03/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage

class AddProductVC: UIViewController {
    

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
    
    var data: AddProductModel?
    var sizeData : SizeModel?
    var pickupLocationData: PickUPLocationModel?
    
    var addImage: [AddProductProductPendingImage] = []
    var imgArray = [#imageLiteral(resourceName: "user_icon"),#imageLiteral(resourceName: "logout")]
    let shippingCategory: [String] = ["SEATING","LIGHTING","STORAGE","RUGS","ART","ACCESSORIES","TABLES"]
    
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
        dropDownTextfieldArray = [txtProductQuantity, txtPickupLocation, txtSellerName, txtShippingCatagory, txtShippingSize, txtDelivery]
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
            var dictParam: [String : Any] = [:]
            dictParam[ Constant.ParameterNames.key ] = serviceKey
            dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
            dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
            dictParam[ Constant.ParameterNames.id] = productId
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.getDataToEditSellerProduct(params: dictParam)
            }
        }else {
            lblTitle.text = Constant.LableText.lbl_title_add_product
            var dictParam: [String : Any] = [:]
            dictParam[ Constant.ParameterNames.key ] = serviceKey
            dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
            dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.getDataToAddSellerProduct(params: dictParam)
            }
        }

        setPicker(pickerView: sellerPicker, field: txtSellerName)
        setPicker(pickerView: quantityPicker, field: txtProductQuantity)
        setPicker(pickerView: shipingSizePicker, field: txtShippingSize)
        setPicker(pickerView: shipingCategoryPicker, field: txtShippingCatagory)
        setPicker(pickerView: pickupLocationPicker, field: txtPickupLocation)
        setPicker(pickerView: deliveryLocationPicker, field: txtDelivery)
        
    }
}

//MARK: Button Actions
extension AddProductVC{
    @IBAction func btnProfileAction(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender as UIView, with: ["My Profile","Logout"], menuImageArray: imgArray, done: { (selectedIndex) -> () in
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
    @IBAction func btnMaterialAction(_ sender: UIButton) {
    }
    @IBAction func btnPetAction(_ sender: UIButton) {
    }
    @IBAction func btnUploadImageAction(_ sender: UIButton) {
        CameraHandler.shared.imagePickedBlock = { (image) in
            GlobalFunction.showLoadingIndicator()
            self.imageUpload(image: image)
        }
        CameraHandler.shared.showActionSheet(vc: self)
    }
    @IBAction func btnSaveAction(_ sender: UIButton) {
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

//MARK: WebService Call
extension AddProductVC{
    func getDataToAddSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.add_seller_product_for_production_stage, params: params) { (responseDict, status) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.getSize()
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.data = AddProductModel(fromDictionary: responseDict as! [String : Any])
                self.productDetailCollectionView.reloadData()
            }
            self.txtSellerName.isEnabled = true
            self.txtProductQuantity.isEnabled = true
            self.txtShippingSize.isEnabled = true
            self.txtShippingCatagory.isEnabled = true
            self.txtPickupLocation.isEnabled = true
            self.txtDelivery.isEnabled = true
        }
    }
    func getDataToEditSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.edit_seller_product_for_production_stage, params: params) { (responseDict, status) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.getSize()
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.data = AddProductModel(fromDictionary: responseDict as! [String : Any])
                self.productDetailCollectionView.reloadData()
                self.setData()
            }
            self.txtSellerName.isEnabled = false
            self.txtSellerName.backgroundColor =  UIColor(red: 222.0 / 255, green: 222.0 / 255, blue: 222.0 / 255, alpha: 1.0)
            self.txtProductQuantity.isEnabled = true
            self.txtShippingSize.isEnabled = true
            self.txtShippingCatagory.isEnabled = true
            self.txtPickupLocation.isEnabled = true
            self.txtDelivery.isEnabled = true
            
        }
    }
    func getSize() {
        WebAPIManager.makeAPIRequest(method: .get, isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_size, params: [:]) { (responseDict, status) in
            let data = responseDict[ Constant.ParameterNames.data ] as! NSArray
            var dict:[[String : Any]] = []
            for size in data {
                dict.append(size as! [String : Any])
            }
            let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
            
            self.sizeData = SizeModel(fromDictionary: parentDict)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                var dictParam: [String : Any] = [:]
                dictParam[Constant.ParameterNames.key] = serviceKey
                dictParam[Constant.ParameterNames.seller_id] = self.sellerId
                self.getPickupLocation(params: dictParam)
            }
        }
    }
    func getPickupLocation(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_pickup_location, params: params) { (responseDict, status) in
            let data = responseDict[Constant.ParameterNames.data] as! NSArray
            var dict:[[String : Any]] = []
            for size in data {
                dict.append(size as! [String : Any])
            }
            let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
            self.pickupLocationData = PickUPLocationModel(fromDictionary: parentDict)
        }
    }
    func callDeleteImage(params: [String : Any], id : Int) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.delete_product_image, params: params) { (responseDict, status) in
            if status == 200{
                self.multiOptionAlertBox(title: Messages.success, message: Messages.imageRemoved, action1: "Ok") { (_ ) in
                    //model of pending images is filtered for refresh collection locally
                    self.data?.data.product.productId?.productPendingImages = self.data?.data.product.productId?.productPendingImages.filter{ $0.id != id }
                    self.photoCollectionView.reloadData()
                }
            }else {
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
                let imgResponse = responseDict[ Constant.ParameterNames.data ] as? [String:Any]
                let img = AddProductProductPendingImage(fromDictionary: imgResponse ?? [:])
                if self.isEditView{
                    self.data?.data.product.productId?.productPendingImages.append(img)
                }else {
                    self.addImage.append(img)
                }
                
                self.photoCollectionView.reloadData()
            }else{
                self.alertbox(title: Messages.error, message: responseDict["message"] as? String ?? "Error Ave Chhhe")
            }
        }
    }
}

//MARK: Set data when load
extension AddProductVC{
  func setData()
  {
    let productData = data?.data.product
    let sellerData = data?.data.sellers.filter{ $0.id == sellerId }
    txtSellerName.text = sellerData![0].displayname
    txtProductName.text = productData?.productId.name
    txtProductQuantity.text = productData?.productId.quantity
    txtRetailPrice.text = productData?.productId.price
    txtTlvPrice.text = productData?.productId.tlvPrice
    txtCommision.text = productData?.commission
    txtUnits.text = productData?.units
    txtWidth.text = productData?.width
    txtDepth.text = productData?.depth
    txtHeight.text = productData?.height
    txtSeatHeight.text = productData?.seatHeight
    txtArmHeight.text = productData?.armHeight
    txtShippingSize.text = productData?.productId.shipSize
    if productData?.productId.shipCat != ""{
        txtShippingCatagory.text = shippingCategory[ Int((productData?.productId.shipCat)!)! - 1 ]
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
    txtPickupLocation.text = productData?.productId.pickUpLocation?.valueText
    txtDelivery.text = productData?.deliveryOption
    btnMaterial.isSelected = productData?.productId.shipMaterial ?? false
    btnPetYes.isSelected = productData?.productId.petFree == "yes" ?  true : false
    btnPetNo.isSelected = productData?.productId.petFree != "yes" ? true : false
    photoCollectionView.reloadData()
    }
}

//MARK: Collection View Delegate methods
extension AddProductVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productDetailCollectionView{
            let numberOfCell = data?.data.categories.count
            return numberOfCell ?? 0
        }else {
            if self.isEditView{
                return self.data?.data.product.productId?.productPendingImages.count ?? 0
            }else {
                return self.addImage.count
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productDetailCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.addProductDetailCell, for: indexPath as IndexPath) as! AddProductDetailCell
            let category = data?.data.categories[indexPath.row]
            cell.lblFieldName.text = category?.categoryName
            cell.lblFieldTitle.isHidden = true
            cell.contentView.layer.cornerRadius = 5.0
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 1.0
            cell.layer.masksToBounds = false
            return cell
        }else {
            var images: [AddProductProductPendingImage] = []
            if self.isEditView {
                images = data?.data.product.productId.productPendingImages ?? []
            }else {
                images = self.addImage
            }
            let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.addDataPictureCell, for: indexPath as IndexPath) as! AddDataPictureCell
            let imgUrl = image_base_url + (images[indexPath.row].name)!
            pictureCell.imageView!.sd_setImage(with: URL(string: imgUrl), completed: nil)
            uvNoImageAvailable.backgroundColor = .clear
            uvNoImageAvailable.isHidden = true
            lblNoImageAvailable.isHidden = true
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
            return pictureCell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productDetailCollectionView{
            let category = data?.data.categories[indexPath.row]
            //        category?.subcategories.count
            //        category?.subcategories[0].subCategoryName
                    print(category!)
        }else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.photoVc) as! PhotoVC
            popUpEffectType = .flipUp
            vc.imgUrls = data?.data.product.productId.productPendingImages
            self.presentPopUpViewController(vc)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productDetailCollectionView {
            return CGSize(width: (100), height: 35)
        } else {
            return CGSize(width: 80, height: 80)
        }
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
            return (sizeData?.data.count)!
        }else if pickerView == shipingCategoryPicker {
            return shippingCategory.count
        }else if pickerView == pickupLocationPicker {
            return (pickupLocationData?.data.count)! + 1
        }else if pickerView == deliveryLocationPicker {
            return 0
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
            return sizeData?.data[row].valueText
        }else if pickerView == shipingCategoryPicker {
            return shippingCategory[row]
        }else if pickerView == pickupLocationPicker {
            return row == 0 ? "Add Location" : pickupLocationData?.data[row - 1].valueText
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
            txtShippingSize.text = sizeData?.data[row].valueText
        }else if pickerView == shipingCategoryPicker{
            txtShippingCatagory.text = shippingCategory[row]
        }else if pickerView == pickupLocationPicker{
            txtPickupLocation.text = row == 0 ? "Add Location" : pickupLocationData?.data[row - 1].valueText
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
        field.inputView = pickerView
        field.isEnabled = false
    }
}
