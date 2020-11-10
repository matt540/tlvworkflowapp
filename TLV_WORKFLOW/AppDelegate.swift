//
//  AppDelegate.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        checkLogin()
        return true
    }
    
    func checkLogin() {
        
        var nav : UINavigationController?
        
        if isKeyPresentInUserDefaults(key: Constant.UserDefaultKeys.currentUserModel){
            do {
                let data = UserDefaults.standard.data(forKey: Constant.UserDefaultKeys.currentUserModel)
                let decodedUserData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! LoginModel
                currentLoginUser = decodedUserData
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.productListVC) as! ProductListVC
                
                 nav = UINavigationController(rootViewController: vc)
            }catch {
            }
        }else {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.loginVC) as! LoginVC
            
             nav = UINavigationController(rootViewController: vc)
        }
        
        nav?.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

