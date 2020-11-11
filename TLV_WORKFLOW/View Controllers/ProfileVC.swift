//
//  ProfileVC.swift
//  TLV_WORKFLOW
//
//  Created by HariKrishna Kundariya on 29/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var txtFirstName: ACFloatingTextfield!
    @IBOutlet weak var txtLastName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtPhoneNo: ACFloatingTextfield!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    
    var profileImage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.isUserInteractionEnabled = false
        self.profileValueSet()
    }
    
}

extension ProfileVC{
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismissPopUp()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        if txtFirstName.text == ""{
            self.view.makeToast(Constant.validationMessage.emptyFirstNameMSG)
        }else if txtLastName.text == ""{
            self.view.makeToast(Constant.validationMessage.emptyLastNameMSG)
        }else if txtPassword.text == ""{
            self.view.makeToast(Constant.validationMessage.emptyPasswordMSG)
        }else if GlobalFunction.isValidPassword(password: txtPassword.text!){
            self.view.makeToast(Constant.validationMessage.passwordValidation)
        }else if txtPhoneNo.text == ""{
            self.view.makeToast(Constant.validationMessage.emptyPhoneNoMSG)
        }else{
            var params: [String : Any] = [:]
            params[Constant.ParameterNames.key] = serviceKey
            params[Constant.ParameterNames.id] = currentLoginUser.data.id
            params[Constant.ParameterNames.firstName] = txtFirstName.text!
            params[Constant.ParameterNames.lastName] = txtLastName.text!
            params[Constant.ParameterNames.phoneNo] = txtPhoneNo.text!
            params[Constant.ParameterNames.password] = txtPassword.text!
            params[Constant.ParameterNames.email] = txtEmail.text!
            params[Constant.ParameterNames.profileImage] = profileImage
            GlobalFunction.showLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.callUpdateUserService(params: params)
            }
        }
    }
    @IBAction func btnProfileAction(_ sender: Any) {
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.imgProfile.image = image
            self.imageUpload()
        }
        CameraHandler.shared.showActionSheet(vc: self)
    }
}
extension ProfileVC{
    //MARK:- Value set
    func profileValueSet(){
        self.txtFirstName.text = currentLoginUser.data.firstname
        self.txtLastName.text = currentLoginUser.data.lastname
        self.txtEmail.text = currentLoginUser.data.email
        self.txtPassword.text = currentLoginUser.data.otherPassword
        self.txtPhoneNo.text = currentLoginUser.data.phone
        if currentLoginUser.data.profileImage == "" {
            
        }else{
            let imageUrl = profileImageUrl + currentLoginUser.data.profileImage!
            self.imgProfile.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "user_placeHolder"), options: .continueInBackground, context: nil)
        }
    }
    
    //MARK:- Image Upload function
    func imageUpload() {
        let image = imgProfile.image
        let imagesData = ["photo": [GlobalFunction.resizeImage(image: image!)]]
        var params:[String:String] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.folder] = Constant.FolderNames.profile
        WebAPIManager.makeMultipartRequestToUploadImages(isFormDataRequest: true, isContainXAPIToken: true, isContainContentType: true, path: Constant.Api.imageUpload, parameters: params, imagesData: [imagesData]) { (responseDict, status) in
            if responseDict["code"] as! Int == 200{
                let imageData = responseDict["data"] as! [String : Any]
                self.profileImage = imageData["name"] as! String
            }else{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    //MARK:- Api Calling Function
    func callUpdateUserService(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.editUserProfile, params: params) { (responseDict, status) in
            if status == 0{
                self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }else{
                let userDataProfile = EditUserModel(fromDictionary: responseDict as! [String : Any])
                userDataProfile.data.roles = currentLoginUser.data.roles
                let userDataProfileDict = userDataProfile.toDictionary()
                
                let userDataLogin = LoginModel(fromDictionary: userDataProfileDict)
                do {
                    let encodedUserData: Data = try NSKeyedArchiver.archivedData(withRootObject: userDataLogin, requiringSecureCoding: false)
                    
                    UserDefaults.standard.set(encodedUserData, forKey: Constant.UserDefaultKeys.currentUserModel)
                    UserDefaults.standard.synchronize()
                    currentLoginUser = userDataLogin
                    self.multiOptionAlertBox(title: Messages.tlv, message: Messages.dataUpdatedSuccessfully, action1: "OK") { (_ ) in
                        self.dismissPopUp()
                    }
                }catch {
                    
                }
            }
        }
    }
}

extension ProfileVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName{
            txtLastName.becomeFirstResponder()
            return true
        }else if textField == txtLastName{
            txtPassword.becomeFirstResponder()
            return true
        }else if textField == txtPassword{
            txtPhoneNo.becomeFirstResponder()
            return true
        }else{
            textField.resignFirstResponder()
            return true
        }
    }
}

