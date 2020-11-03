//
//  AddProductVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 03/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class AddProductVC: UIViewController {
    
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
    
    //MARK: uiview outlets
    @IBOutlet weak var ageView: UIView!
    
    //MARK: collection view outlets
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    
    var textFieldArray: [UITextField] = []
    var dropDownTextfieldArray: [UITextField] = []
    
    var sellerPicker = UIPickerView()
    
    var data: AddProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageView.isHidden = true
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

        sellerPicker.isUserInteractionEnabled = true
        sellerPicker.delegate = self
        sellerPicker.dataSource = self
        txtSellerName.inputView = sellerPicker
        txtSellerName.isEnabled = false
        
    }
}

//MARK: Button Actions
extension AddProductVC{
    @IBAction func btnProfileAction(_ sender: UIButton) {
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
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
                self.data = AddProductModel(fromDictionary: responseDict as! [String : Any])
            }
            self.txtSellerName.isEnabled = true
        }
    }
}


//MARK: Picker View Delegate methods
extension AddProductVC: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (data?.data.sellers.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data?.data.sellers[row].displayname
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
    }
}
