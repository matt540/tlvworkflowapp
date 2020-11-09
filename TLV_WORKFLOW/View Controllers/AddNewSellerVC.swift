//
//  AddNewSellerVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 30/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class AddNewSellerVC: UIViewController {

    @IBOutlet weak var txtFirstName: ACFloatingTextfield!
    @IBOutlet weak var txtLastName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtPhoneNo: ACFloatingTextfield!
    @IBOutlet weak var txtAddress: ACFloatingTextfield!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSave.isEnabled = false
        self.btnSave.backgroundColor = UIColor.lightGray
    }

}

//MARK:- IBActions
extension AddNewSellerVC{
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismissPopUpViewController()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        if txtFirstName.text == ""{
            txtFirstName.showErrorWithText(errorText: Constant.validationMessage.emptyFirstNameMSG)
            txtFirstName.showError()
        }else if txtLastName.text == ""{
            txtLastName.showErrorWithText(errorText: Constant.validationMessage.emptyLastNameMSG)
            txtLastName.showError()
        }else if txtEmail.text == ""{
            txtEmail.showErrorWithText(errorText: Constant.validationMessage.emptyEmailMSG)
            txtEmail.showError()
        }else if !GlobalFunction.isValidEmail(email: txtEmail.text!){
            txtEmail.showErrorWithText(errorText: Constant.validationMessage.invalidEmailMSG)
            txtEmail.showError()
        }else if txtPassword.text == ""{
            txtPassword.showErrorWithText(errorText: Constant.validationMessage.emptyPasswordMSG)
            txtPassword.showError()
        }else if GlobalFunction.isValidPassword(password: txtPassword.text!){
            txtPassword.showErrorWithText(errorText: Constant.validationMessage.passwordValidation)
            txtPassword.showError()
        }else if txtPhoneNo.text == ""{
            txtPhoneNo.showErrorWithText(errorText: Constant.validationMessage.emptyPhoneNoMSG)
            txtPhoneNo.showError()
        }else{
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callSaveSeller()
            }
        }
    }
}


extension AddNewSellerVC{
    
    //MARK:- Emailexist check Api
    func callCheckEmail(){
        var params:[String :Any] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.userEmail] = txtEmail.text!
        
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.check_seller_email_exists, params: params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                let data = responseDict["data"] as! [String : Any]
                let flag = data["email_exists"] as! String
                if flag == "1"{
                    self.txtEmail.showErrorWithText(errorText: Constant.validationMessage.emailExist)
                    self.txtEmail.showError()
                }else{
                    self.txtPassword.becomeFirstResponder()
                    self.btnSave.isEnabled = true
                    self.btnSave.backgroundColor = UIColor.init(red: 149.0/255, green: 214.0/255, blue: 10.0/255, alpha: 1.0)
                }
            }
        }
    }
    
    //MARK:- Add Seller API calling
    func callSaveSeller() {
        var params:[String: Any] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.firstName] = txtFirstName.text!
        params[Constant.ParameterNames.lastName] = txtLastName.text!
        params[Constant.ParameterNames.email] = txtEmail.text!
        params[Constant.ParameterNames.password] = txtPassword.text!
        params[Constant.ParameterNames.phoneNo] = txtPhoneNo.text!
        params[Constant.ParameterNames.address] = txtAddress.text ?? ""
        
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.save_new_seller, params: params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                let dict = responseDict["data"] as! [String : Any]
                let dictData = dict["data"] as! [String : Any]
                let strWP_ID = dictData["ID"] as! String
                if strWP_ID.count != 0{
                    var params : [String : Any] = [:]
                    params[Constant.ParameterNames.key] = serviceKey
                    params[Constant.ParameterNames.wp_seller_id] = strWP_ID
                    GlobalFunction.showLoadingIndicator()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.callGetSellerInfo(Params: params)
                    }
                }
            }
        }
    }
    
    //MARK:- Get SellerInfo from Id API Calling
    func callGetSellerInfo(Params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_sellerById, params: Params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                let dict = responseDict["data"] as! [String : Any]
                self.multiOptionAlertBox(title: Messages.tlv, message: Messages.sellerAddedSuccessFully, action1: "OK") { (_ ) in
                    self.reloadMainScreen(dict: dict)
                    self.dismissPopUpViewController()
                }
            }
        }
    }
    
    //MARK:- Change VC
    func reloadMainScreen(dict: [String :Any]){
        let addProductVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.addProductVC) as! AddProductVC
        addProductVC.isEditView = false
        addProductVC.sellerId = dict["id"] as? Int
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
}

extension AddNewSellerVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName{
            txtLastName.becomeFirstResponder()
        }else if textField == txtLastName{
            txtEmail.becomeFirstResponder()
        }else if textField == txtEmail{
            if txtEmail.text == ""{
                txtEmail.showErrorWithText(errorText: Constant.validationMessage.emptyEmailMSG)
                txtEmail.showError()
            }else if !GlobalFunction.isValidEmail(email: txtEmail.text!){
                txtEmail.showErrorWithText(errorText: Constant.validationMessage.invalidEmailMSG)
                txtEmail.showError()
            }else{
                txtPassword.becomeFirstResponder()
            }
        }else if textField == txtPassword {
            if txtPassword.text == ""{
                txtPassword.showErrorWithText(errorText: Constant.validationMessage.emptyPasswordMSG)
                txtPassword.showError()
            }else if GlobalFunction.isValidPassword(password: txtPassword.text!){
                txtPassword.showErrorWithText(errorText: Constant.validationMessage.passwordValidation)
                txtPassword.showError()
            }else{
                txtPhoneNo.becomeFirstResponder()
            }
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    //MARK:- Email validation Check
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         if textField == txtEmail{
            if txtEmail.text == ""{
                txtEmail.showErrorWithText(errorText: Constant.validationMessage.emptyEmailMSG)
                txtEmail.showError()
            }else if !GlobalFunction.isValidEmail(email: txtEmail.text!){
                txtEmail.showErrorWithText(errorText: Constant.validationMessage.invalidEmailMSG)
                txtEmail.showError()
            }else{
                GlobalFunction.showLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.callCheckEmail()
                }
            }
        }
        return true
    }
}

