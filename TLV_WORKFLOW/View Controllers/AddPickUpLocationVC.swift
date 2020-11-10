//
//  AddPickUpLocationVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 10/11/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class AddPickUpLocationVC: UIViewController {
    
    
    @IBOutlet weak var txtCity: ACFloatingTextfield!
    @IBOutlet weak var txtState: ACFloatingTextfield!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var stateData: [Any] = []
    var statePicker  = UIPickerView()
    var sellerId:Int?
    var AddLocationCompletion : ((Int)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalFunction.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.callGetStateData()
        }
        
        statePicker.isUserInteractionEnabled = true
        statePicker.delegate = self
        statePicker.dataSource = self
        
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
        txtState.inputAccessoryView = keyboardToolbar
        txtState.inputView = statePicker
        dropDownDesign(textField: txtState)
    }
    @objc func yourTextViewDoneButtonPressed(){
        self.view.endEditing(true)
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismissPopUpViewController()
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        if txtCity.text == ""{
            txtCity.showErrorWithText(errorText: Constant.validationMessage.emptyCityMSG)
            txtCity.showError()
        }else if txtState.text == ""{
            txtState.showErrorWithText(errorText: Constant.validationMessage.emptyStateMSG)
            txtState.showError()
        }else{
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callSaveLoaction()
            }
        }
    }
}

//MARK:- Web service api calling
extension AddPickUpLocationVC {
    func callGetStateData(){
        var params: [String:Any] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.getState, params: params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                self.stateData = responseDict["data"] as! Array
            }
        }
    }
    
    func callSaveLoaction(){
        var params: [String:Any] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.seller_id] = sellerId
        params[Constant.ParameterNames.city] = txtCity.text
        params[Constant.ParameterNames.state] = txtState.text
        
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.saveNewLocation, params: params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                let dict = responseDict["data"] as! [String : Any]
                self.multiOptionAlertBox(title: Messages.tlv, message: Messages.locationAddedSuccessFully, action1: "OK") { (_ ) in
                    self.AddLocationCompletion?(dict["pickup_id"] as! Int)
                    self.dismissPopUpViewController()
                }
            }
        }
    }
}
extension AddPickUpLocationVC{
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
}
extension AddPickUpLocationVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.stateData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateData[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtState.text = stateData[row] as? String
    }
}

