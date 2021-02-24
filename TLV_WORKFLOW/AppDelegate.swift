//
//  AppDelegate.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit
import CoreData

var notificationCenter = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var addImage = [[String:Any]]()
    var temp = 0
    var temp1 = 0
    var reachability: Reachability?
    let topWindow = UIWindow(frame: UIScreen.main.bounds)
    var sellerDataOffline = ""
    var temp2 = 0
    var editImage = [[String:Any]]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkLogin()
        return true
    }
    
    func checkLogin() {
        var nav : UINavigationController?
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.splashVC) as! SplashVC
        nav = UINavigationController(rootViewController: vc)
        nav?.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    func getDataToAddSellerProduct(params: [String : Any]){
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.add_seller_product_for_production_stage, params: params) { (responseDict, status) in
            
            if status == 200{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let JsonData = try?JSONSerialization.data(withJSONObject: responseDict as! [String : Any], options: [])
                    self.sellerDataOffline = String(data: JsonData!, encoding: .utf8)!
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.getSize()
                    }
                }
            }else{
               self.window?.rootViewController?.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    func getSize(){
           WebAPIManager.makeAPIRequest(method: .get, isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_size, params: [:]) { (responseDict, status) in
               
               let data = responseDict[ Constant.ParameterNames.data ] as? NSArray
               var dict:[[String : Any]] = []
               for size in data ?? [] {
                   dict.append(size as! [String : Any])
               }
               let parentDict:[String : Any] = [Constant.ParameterNames.data:dict]
               let sizeData = SizeModel(fromDictionary: parentDict)
               if sizeData.data.count > 0{
                   var sizeListString = [String]()
                   for i in sizeData.data{
                       let JsonData = try?JSONSerialization.data(withJSONObject: i.toDictionary(), options: [])
                       let jsonString = String(data: JsonData!, encoding: .utf8)!
                       sizeListString.append(jsonString)
                   }
                   let sizeString = sizeListString.joined(separator:"-")
                   
                   let shipSizeData = DataInfo().retriveDataShipSize()
                   if shipSizeData.count > 0{
                       DataInfo().updateDataShipSize(id: 0, shipSizeData: sizeString)
                   }else{
                       DataInfo().createDataShipSize(shipSizeData: sizeString)
                   }
               }
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   var dictParam: [String : Any] = [:]
                   dictParam[Constant.ParameterNames.key] = serviceKey
                   //dictParam[Constant.ParameterNames.seller_id] = self.sellerId
                   self.getPickupLocation(params: dictParam)
               }
           }
       }
    
    func getPickupLocation(params: [String : Any]) {
        WebAPIManager.makeAPIRequest(isFormDataRequest: true, isContainContentType: true, path: Constant.Api.get_pickup_location, params: params) { (responseDict, status) in
            
            if status == 200{
                let data = responseDict[Constant.ParameterNames.data] as! NSArray
                var dict:[[String : Any]] = []
                for size in data {
                    dict.append(size as! [String : Any])
                }
                
                let parentDict1:[String : Any] = [Constant.ParameterNames.data:dict]
                let pickupLocationData = PickUPLocationModel(fromDictionary: parentDict1)
                
                if pickupLocationData.data.count > 0{
                    let JsonData = try?JSONSerialization.data(withJSONObject: responseDict as! [String : Any], options: [])
                    let locationString = String(data: JsonData!, encoding: .utf8)!
                    let shopData = DataInfo().retriveDataShop()
                    if shopData.count > 0{
                        DataInfo().updateDataShop(id: 0, pickLocation: locationString, sellerData: self.sellerDataOffline)
                    }else{
                        DataInfo().createDataShop(pickLocation: locationString,sellerData: self.sellerDataOffline)
                    }
                }
            }else{
                 self.window?.rootViewController?.alertbox(title: Messages.error, message: responseDict["message"] as! String)
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TLV_WORKFLOW")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
