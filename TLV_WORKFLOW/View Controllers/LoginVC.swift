//
//  LoginVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: BaseViewController {
    
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Login Button Action Event
    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        if isValidate() {
            var params: [String : Any] = [:]
            params[Constant.ParameterNames.email] = txtEmail.text!
            params[Constant.ParameterNames.password] = txtPassword.text!
            GlobalFunction.showLoadingIndicator()
            WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.login, params: params) { (responseDict, status) in
                if status == 200{
                    GlobalFunction.hideLoadingIndicator()
                    let userData = LoginModel(fromDictionary: responseDict as! [String : Any])
                    do {
                        let encodedUserData: Data = try NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedUserData, forKey: Constant.UserDefaultKeys.currentUserModel)
                        UserDefaults.standard.synchronize()
                        currentLoginUser = userData
                        
                        var dictParam: [String : Any] = [:]
                        dictParam[ Constant.ParameterNames.key ] = serviceKey
                        dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
                        dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            AppDelegate().getDataToAddSellerProduct(params: dictParam)
                        }
                        
                        let productListVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.productListVC) as! ProductListVC
                        self.navigationController?.pushViewController(productListVC, animated: true)
                        
                    }catch {
                        
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                   self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                }
            }
        }
    }
    
    //MARK: validate function for textfields
    func isValidate() -> Bool {
        if txtEmail.text == ""{
            self.view.makeToast(Constant.validationMessage.emptyEmailMSG)
            return false
        }else if txtPassword.text == ""{
            self.view.makeToast(Constant.validationMessage.emptyPasswordMSG)
            return false
        }else if  !GlobalFunction.isValidEmail(email: txtEmail.text!) {
            self.view.makeToast(Constant.validationMessage.invalidEmailMSG)
            return false
        }
        return true
    }
}

//MARK: delegate method of text field
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
            return true
        }else {
            textField.resignFirstResponder()
            return true
        }
    }
}
