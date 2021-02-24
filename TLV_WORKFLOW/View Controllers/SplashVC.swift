//
//  SplashVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    var addImage = [[String:Any]]()
    var temp = 0
    var temp1 = 0
    var reachability: Reachability?
    var sellerDataOffline = ""
    var temp2 = 0
    var editImage = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkCheck()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.isKeyPresentInUserDefaults(key: Constant.UserDefaultKeys.currentUserModel){
                do {
                    let data = UserDefaults.standard.data(forKey: Constant.UserDefaultKeys.currentUserModel)
                    let decodedUserData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! LoginModel
                    currentLoginUser = decodedUserData
                    if GlobalFunction.isNetworkReachable(){
                        var dictParam: [String : Any] = [:]
                        dictParam[ Constant.ParameterNames.key ] = serviceKey
                        dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
                        dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            AppDelegate().getDataToAddSellerProduct(params: dictParam)
                        }
                    }
                    let productListVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.productListVC) as! ProductListVC
                    self.navigationController?.pushViewController(productListVC, animated: true)
                }catch {
                    
                }
            }else {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.VCIdentifier.loginVC) as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func networkCheck(){
        do{
            self.reachability = try Reachability.init()
            if self.reachability?.connection != .unavailable{
                let data = DataInfo().retriveAddProductData()
                let editData = DataInfo().retriveEditProductData()
                if data.count > 0 || editData.count > 0{
                    if data.count > 0{
                        self.syncData()
                    }
                    if editData.count > 0{
                        self.syncEditData()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
                            self.startReachabilty()
                        }
                    }
                }else{
                    startReachabilty()
                }
            }else{
                startReachabilty()
            }
        }catch{
            print("Error")
        }
    }
    
    func startReachabilty(){
        do{
            self.reachability = try Reachability.init()
            if self.reachability?.connection != .unavailable{
                let data = DataInfo().retriveAddProductData()
                let editData = DataInfo().retriveEditProductData()
                if data.count > 0 || editData.count > 0{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let alert = UIAlertController(title: Messages.tlv, message: Messages.syncDataMsg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                            if data.count > 0{
                                GlobalFunction.showLoadingIndicator()
                                self.syncData()
                            }
                            if editData.count > 0{
                                GlobalFunction.showLoadingIndicator()
                                self.syncEditData()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
                                self.startReachabilty()
                            }
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.startReachabilty()
                    }
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.startReachabilty()
                }
            }
        }catch{
            print("error")
        }
    }
    
    //MARK:- Offline Product Data
    func syncData(){
        let images = DataInfo().retriveImageData()
        if images.count > 0{
            for i in 0..<images.count{
                    DispatchQueue.main.async(execute: { [self] in
                        let dict = images[i]
                        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                        let documentsDirectory = paths[0]
                        var writableDBPath: String? = nil
                        writableDBPath = URL(fileURLWithPath: documentsDirectory.path).appendingPathComponent(dict.image_url ?? "").path
                        let pngData = NSData(contentsOfFile: writableDBPath ?? "") as Data?
                        var image: UIImage? = nil
                        if let pngData = pngData {
                            image = UIImage(data: pngData)
                        }
                        let intnUm = (dict.p_id as NSNumber).intValue
                        self.imageUpload(image: image ?? UIImage(), count: intnUm)
                    })
            }
        }else{
            let productData = DataInfo().retriveAddProductData()
            if productData.count > 0{
                for i in productData{
                    let params = GlobalFunction.convertToDictionary(text: i.product_detail ?? "")
                    self.saveProduct(params: params ?? [:], withId: Int(i.id))
                }
            }
        }
    }
    
    func imageUpload(image: UIImage, count: Int) {
        let image = image
        let imagesData = ["photo": [GlobalFunction.resizeImage(image: image)]]
        var params:[String:String] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.folder] = Constant.FolderNames.product
        WebAPIManager.makeMultipartRequestToUploadImages(isFormDataRequest: true, isContainXAPIToken: true, isContainContentType: true, path: Constant.Api.upload_product_image, parameters: params, imagesData: [imagesData]) { (responseDict, status) in
            if responseDict["code"] as! Int == 200{
                self.temp = self.temp + 1
                let imgResponse = responseDict[ Constant.ParameterNames.data ] as? [String:Any]
                var dictTemp = [String:Any]()
                dictTemp["id"] = imgResponse?["id"]
                dictTemp["p_id"] = count
                self.addImage.append(dictTemp)
                let images = DataInfo().retriveImageData()
                if images.count == self.temp{
                    let productData = DataInfo().retriveAddProductData()
                    for i in productData{
                        var imageArray:[Int] = []
                        for j in self.addImage{
                            if i.id == j["p_id"] as! Int{
                                imageArray.append(j["id"] as! Int)
                            }
                        }
                        var params = GlobalFunction.convertToDictionary(text: i.product_detail ?? "")
                        var productQuatation = params?["product_quotation"] as! [String:Any]
                        productQuatation["images"] = imageArray
                        params?["product_quotation"] = productQuatation
                        self.saveProduct(params: params ?? [:], withId: Int(i.id))
                    }
                }
            }else{
                GlobalFunction.hideLoadingIndicator()
                self.alertbox(title: Messages.error, message: responseDict["message"] as? String ?? Messages.error)
            }
        }
    }
    
    func saveProduct(params : [String : Any], withId :Int) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.save_product_for_productions, params: params) { (responseDict, status) in
            if status == 200{
                DataInfo().deleteAddProductData(id: withId)
                let images = DataInfo().retriveImageData()
                if images.count > 0{
                    for i in images{
                        if i.p_id == withId{
                            DataInfo().deleteImageData(image_url: i.image_url ?? "")
                        }
                    }
                }
                NotificationCenter.default.post(name: .sellerDataReload, object: nil,userInfo: nil)
                NotificationCenter.default.post(name: .productDataReload, object: nil,userInfo: nil)
                GlobalFunction.hideLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
                    self.startReachabilty()
                }
            }else{
                self.alertbox(title: "\(status)", message: responseDict[Constant.ParameterNames.status] as! String)
            }
        }
    }
    
    func syncEditData(){
        let editProduct = DataInfo().retriveEditProductData()
        for i in editProduct{
            let imageData = DataInfo().retriveEditImageData(productId: Int(i.product_id))
            if imageData.count > 0{
                for j in imageData{
                    editImageUpload(image: j.imagedata!,productId: Int(i.product_id))
                }
            }else{
                var params = GlobalFunction.convertToDictionary(text: i.productdata ?? "")
                var productQuatation = params?["product_quotation"] as! [String:Any]
                productQuatation["images"] = []
                params?["product_quotation"] = productQuatation
                self.saveEditProduct(params: params ?? [:], withId: Int(i.product_id))
            }
        }
        self.temp2 = 0
    }
    
    func editImageUpload(image: Data, productId: Int){
        let image = UIImage(data: image) ?? UIImage()
        let imagesData = ["photo": [GlobalFunction.resizeImage(image: image)]]
        var params:[String:String] = [:]
        params[Constant.ParameterNames.key] = serviceKey
        params[Constant.ParameterNames.folder] = Constant.FolderNames.product
        
        WebAPIManager.makeMultipartRequestToUploadImages(isFormDataRequest: true, isContainXAPIToken: true, isContainContentType: true, path: Constant.Api.upload_product_image, parameters: params, imagesData: [imagesData]) { (responseDict, status) in
            if responseDict["code"] as? Int == 200{
                self.temp2 = self.temp2 + 1
                let imgResponse = responseDict[ Constant.ParameterNames.data ] as? [String:Any]
                var dictTemp = [String:Any]()
                dictTemp["id"] = imgResponse?["id"]
                dictTemp["product_id"] = productId
                self.editImage.append(dictTemp)
                let images = DataInfo().retriveEditImageData(productId: productId)
                if images.count == self.temp2{
                    let productData = DataInfo().retriveEditProductData()
                    for i in productData{
                        var imageArray:[Int] = []
                        for j in self.editImage{
                            if i.product_id == j["product_id"] as! Int{
                                imageArray.append(j["id"] as! Int)
                            }
                        }
                        self.editImage = []
                        var params = GlobalFunction.convertToDictionary(text: i.productdata ?? "")
                        var productQuatation = params?["product_quotation"] as! [String:Any]
                        productQuatation["images"] = imageArray
                        params?["product_quotation"] = productQuatation
                        self.saveEditProduct(params: params ?? [:], withId: productId)
                    }
                }
            }else{
                self.alertbox(title: Messages.error, message: responseDict["message"] as? String ?? Messages.error)
                GlobalFunction.hideLoadingIndicator()
            }
        }
    }
    func saveEditProduct(params : [String : Any], withId :Int) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.save_product_for_productions, params: params) { (responseDict, status) in
            
            if status == 200{
                DataInfo().deleteEditProductData(id: withId)
                //DataInfo().deleteEditImageDataId(id: withId)
                var dict = [String:Any]()
                dict["id"] = withId
                if notificationCenter{
                    NotificationCenter.default.post(name: .editProductSave, object: nil,userInfo: dict)
                    NotificationCenter.default.post(name: .productDataReload, object: nil,userInfo: nil)
                }else{
                    self.offlineProductData(id: withId)
                }
            }else{
                self.alertbox(title: "\(status)", message: responseDict[Constant.ParameterNames.status] as! String)
            }
        }
    }
    func offlineProductData(id: Int){
        var dictParam: [String : Any] = [:]
        do{
            let data = UserDefaults.standard.data(forKey: Constant.UserDefaultKeys.currentUserModel)
            let decodedUserData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! LoginModel
            currentLoginUser = decodedUserData
        }catch{
            print("error")
        }
        dictParam[ Constant.ParameterNames.key ] = serviceKey
        dictParam[ Constant.ParameterNames.user_id ] = String(format: "%i", currentLoginUser.data.id)
        dictParam[ Constant.ParameterNames.role_id ] = String(format: "%i", currentLoginUser.data.roles[0].id)
        dictParam[ Constant.ParameterNames.id] = id
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            GlobalFunction.showLoadingIndicator()
            self.getDataToEditSellerProduct(params: dictParam)
        }
    }
    func getDataToEditSellerProduct(params: [String : Any]){
            WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.edit_seller_product_for_production_stage, params: params) { (responseDict, status) in
                if status == 200{
                    if DataInfo().isProductDataDetailExists(productId: params[Constant.ParameterNames.id] as! Int){
                        DataInfo().deleteProductDataDetail(productId: params[Constant.ParameterNames.id] as! Int)
                        DataInfo().deleteEditImageDataId(id: params[Constant.ParameterNames.id] as! Int)
                    }
                    let JsonData = try?JSONSerialization.data(withJSONObject: responseDict as! [String : Any], options: [])
                    let productDataOffline = String(data: JsonData!, encoding: .utf8)!
                    let productData = AddProductModel(fromDictionary: responseDict as! [String : Any])
                    DataInfo().createProductData(productId: params[Constant.ParameterNames.id] as! Int, productData: productDataOffline)
                    let image = productData.data.product.productId.productPendingImages ?? []
                    for i in 0..<image.count{
                        let data = try? Data(contentsOf: URL(string: image_base_url + image[i].name)!)
                        DataInfo().createEditImageData(productId: params[Constant.ParameterNames.id] as! Int, imageData: data!, status: 1)
                        if i == image.count - 1 {
                            GlobalFunction.hideLoadingIndicator()
                        }
                    }
                }else{
                    GlobalFunction.hideLoadingIndicator()
                    self.alertbox(title: Messages.error, message: responseDict["message"] as! String)
                }
            }
        }
}
