//
//  AddProductVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 03/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class AddProductVC: UIViewController {
    
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
    
    let shippingCategory: [String] = ["SEATING","LIGHTING","STORAGE","RUGS","ART","ACCESSORIES","TABLES"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = productDetailCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 5
                layout.minimumInteritemSpacing = 5
                layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
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
        txtConditionNotes.text = "Condition Notes"
        txtProductDetail.text = "Diamension/Product Details"
        txtInternalNotes.text = "Internal Notes"
        txtInternalNotes.textColor = .lightGray
        txtConditionNotes.textColor = .lightGray
        txtProductDetail.textColor = .lightGray
        
        var dictParam: [String : Any] = [:]
        dictParam["key"] = serviceKey
        dictParam["user_id"] = String(format: "%i", currentLoginUser.data.id)
        dictParam["role_id"] = String(format: "%i", currentLoginUser.data.roles[0].id)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getSellerrDetail(params: dictParam)
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
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnMaterialAction(_ sender: UIButton) {
    }
    @IBAction func btnPetAction(_ sender: UIButton) {
    }
    @IBAction func btnUploadImageAction(_ sender: UIButton) {
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
                textView.text = "Condition Notes"
            }else if textView == txtProductDetail {
                textView.text = "Diamension/Product Details"
            }else if textView == txtInternalNotes{
                textView.text = "Internal Notes"
            }else {
                print(textView.nibName)
            }
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: WebService Call
extension AddProductVC{
    func getSellerrDetail(params: [String : Any]){
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
    func getSize() {
        WebAPIManager.makeAPIRequest(method: .get, isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_size, params: [:]) { (responseDict, status) in
            let data = responseDict["data"] as! NSArray
            var dict:[[String : Any]] = []
            for size in data {
                dict.append(size as! [String : Any])
            }
            let parentDict:[String : Any] = ["data":dict]
            
            self.sizeData = SizeModel(fromDictionary: parentDict)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                var dictParam: [String : Any] = [:]
                dictParam["key"] = "$2y$10$aROSSAxEG7RgVYPL.f7VWOxWKIcly0ekxrNwc2h1Swktd1g0hl2/C"
                dictParam["seller_id"] = self.sellerId
                self.getPickupLocation(params: dictParam)
            }
        }
    }
    func getPickupLocation(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_pickup_location, params: params) { (responseDict, status) in
            let data = responseDict["data"] as! NSArray
            var dict:[[String : Any]] = []
            for size in data {
                dict.append(size as! [String : Any])
            }
            let parentDict:[String : Any] = ["data":dict]
            self.pickupLocationData = PickUPLocationModel(fromDictionary: parentDict)
        }
    }
}


//MARK: Collection View Delegate methods
extension AddProductVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productDetailCollectionView{
            let numberOfCell = data?.data.categories.count
            return numberOfCell ?? 0
        }else {
            return data?.data.product[0].imagesFrom ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductDetailCell", for: indexPath as IndexPath) as! AddProductDetailCell
        let category = data?.data.categories[indexPath.row]
        cell.lblFieldName.text = category?.categoryName
        cell.lblFieldTitle.isHidden = true
        cvCellDesign(view: cell.uvCellView)
        return cell
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
    func cvCellDesign(view: UIView) {
//        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: txtProductName.frame.size.height))
        view.layer.backgroundColor = UIColor.white.cgColor
//        view.leftView = viewPadding
//        view.leftViewMode = .always
        view.layer.cornerRadius = 5.0
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1.0
    }
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
    }
    
    func setPicker(pickerView: UIPickerView, field: UITextField) {
        pickerView.isUserInteractionEnabled = true
        pickerView.delegate = self
        pickerView.dataSource = self
        field.inputView = pickerView
        field.isEnabled = false
    }
}
