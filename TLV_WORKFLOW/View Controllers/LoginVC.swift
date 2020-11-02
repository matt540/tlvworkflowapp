//
//  LoginVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
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
            
            WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.login, params: params) { (responseDict, status) in
                let userData = LoginModel(fromDictionary: responseDict as! [String : Any])
                do {
                    let encodedUserData: Data = try NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedUserData, forKey: Constant.UserDefaultKeys.currentUserModel)
                    UserDefaults.standard.synchronize()
                    currentLoginUser = userData
                    let productListVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.productListVC) as! ProductListVC
                    self.navigationController?.pushViewController(productListVC, animated: true)
                    
                }catch {
                    
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
