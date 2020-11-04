

import Foundation
import Alamofire

class WebAPIManager: NSObject {
    
    //MARK:- API Call
    
    class func makeAPIRequest(method: HTTPMethod = .post, isFormDataRequest: Bool, isContainContentType: Bool, path: String, params: Parameters, bsaeUrl baseUrl: String = baseUrl, completion: @escaping (_ response: [AnyHashable: Any],_ status: Int) -> Void) {
        
        if !GlobalFunction.isNetworkReachable() {
            UIApplication.shared.windows.first?.makeToast("Please connect internet.")
            return
        }
        
        let baseURL = baseUrl + path
        var customHeader:[String:String] = [:]
        
        if isContainContentType {
            customHeader["Content-Type"] = "application/x-www-form-urlencoded"
        }
        
        var encoding: ParameterEncoding = JSONEncoding.default
        if isFormDataRequest {
            encoding = URLEncoding.default
        }
        
        Alamofire.request(baseURL, method: method, parameters: params, encoding: encoding, headers: customHeader).responseJSON { (response:DataResponse<Any>) in
            
            GlobalFunction.hideLoadingIndicator()
            
            switch(response.result) {
            case .success(_):
                if let responseData = response.result.value as? [AnyHashable : Any] {
                    if let successValue = responseData["code"] as? Int {
                        
                        completion(responseData, successValue)
                    } else if let successValue = responseData["code"] as? NSString {
                        
                        completion(responseData, successValue.integerValue)
                    } else {
                        if let jsonResponse =  responseData["data"] as? [AnyHashable : Any] {
                            if let successValue = jsonResponse["code"] as? Int {
                                
                                completion(jsonResponse, successValue)
                                
                            } else if let successValue = jsonResponse["code"] as? NSString {
                                
                                completion(jsonResponse, successValue.integerValue)
                            }else {
                                
                                print("if last else")
                            }
                        }
                    }
                }else {
                    var dic : [String:Any] = [:]
                    dic["data"] = response.result.value
                    completion(dic,1)
                }
                break
                
            case .failure(_):
                var dict = [AnyHashable: Any]()
                dict["message"] = "Oops! Something went wrong. Please try again."
                dict["status"] = 0
                completion(dict, 0)
                break
            }
        }
    }
    
    class func makeMultipartRequestToUploadImages(method: HTTPMethod = .post, isFormDataRequest: Bool, isContainXAPIToken: Bool, isContainContentType: Bool, path: String, parameters: [String:String], imagesData: [[String: [Data]]], bsaeUrl: String = baseUrl, completion: @escaping (_ response: [AnyHashable: Any],_ status: Int) -> Void) {
        
        if !GlobalFunction.isNetworkReachable() {
            return
        }
        let url = baseUrl + path
        
        //        GlobalFunction.printResponce(From: "Request URL = \(url) parameters = \(parameters) API Token = \(User.sharedInstance.token ?? "")")
        
        var customHeader:[String:String] = [:]
        if isContainXAPIToken {
            customHeader["Content-Type"] = "application/x-www-form-urlencoded"
        }
        
        //            if isContainXAPIToken {
        //                customHeader["X-API-TOKEN"] = User.sharedInstance.token!
        //            }
        
        //            var encoding: ParameterEncoding = JSONEncoding.default
        //            if isFormDataRequest {
        //                encoding = URLEncoding.default
        //            }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            //                multipartFormData.append(self.imageData, withName: "user_image", fileName: "picture.png", mimeType: "image/png")
            if imagesData.count > 0 {
                for data in imagesData {
                    if data.count > 0 {
                        let key = data.keys.first
                        let imagesData = data[key!]
                        let paramKey = key!
                        for dataToUpload in imagesData! {
                            multipartFormData.append(dataToUpload, withName: paramKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                        }
                    }
                }
            }
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key )
            }
        }, to: url, method: method, headers: customHeader, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    //                    GlobalFunction.printResponce(From: "API NAME \(path) :- \(response.result.value ?? "")")
                    GlobalFunction.hideLoadingIndicator()
                    switch(response.result) {
                    case .success(_):
                        
                        if let jsonResponse = response.result.value as? [AnyHashable : Any] {
                            if let successValue = jsonResponse["status"] as? Int {
                                if successValue == 9 {
                                    //                                        self.logoutApi()
                                } else {
                                    completion(jsonResponse, successValue)
                                }
                            }
                            else if let successValue = jsonResponse["status"] as? NSString {
                                if successValue.integerValue == 9 {
                                } else {
                                    completion(jsonResponse, successValue.integerValue)
                                }
                            }
                        }
                        break
                        
                    case .failure(_):
                        var dict = [AnyHashable: Any]()
                        dict["message"] = "Oops! Something went wrong. Please try again."
                        dict["status"] = 0
                        completion(dict, 0)
                        break
                    }
                }).uploadProgress { progress in // main queue by default
                }
                return
            case .failure( _):
                
                var dict = [AnyHashable: Any]()
                dict["message"] = "Oops! Something went wrong. Please try again."
                dict["status"] = 0
                completion(dict, 0)
            }
        })
    }
    
    static func showErrorRespose(errorResponse: [AnyHashable: Any]?) {
        
        DispatchQueue.main.async {
            if errorResponse != nil {
                APP_DELEGATE.window?.makeToast(errorResponse?["message"] as! String)
            }
            GlobalFunction.hideLoadingIndicator()
        }
    }
    
    // MARK:- button search click method call
    //    static func logoutApi() {
    //
    //        guard currentLoginUser != nil else {
    //            return
    //        }
    //
    //        var params: Parameters = [:]
    //        params["user_id"] = currentLoginUser.id
    //
    //        WebAPIManager.makeAPIRequest(method: .post,isFormDataRequest: true, isContainXAPIToken: false, isContainContentType: true, path: Constant.Api.logout, params: params) { (response, status) in
    ////            guard let responseData = response as? [String: Any] else {
    ////                return
    ////            }
    //
    ////            let message = responseData["message"] as! String
    //
    //            if status == 1 {
    //                UserInfoManager.removeUserInfo()
    //                currentLoginUser = UserInfoManager.getUserInfoModel()
    //                APP_DELEGATE.resetRoot()
    ////                self.navigationController.popToRootViewController(animated: false)
    ////                APP_DELEGATE.window?.makeToast(message)
    //            }else {
    ////                APP_DELEGATE.window?.makeToast(message)
    //            }
    //        }
    //    }
    
    
}
