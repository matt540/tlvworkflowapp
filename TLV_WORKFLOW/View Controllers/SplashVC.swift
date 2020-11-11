//
//  SplashVC.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.isKeyPresentInUserDefaults(key: Constant.UserDefaultKeys.currentUserModel){
                do {
                    let data = UserDefaults.standard.data(forKey: Constant.UserDefaultKeys.currentUserModel)
                    let decodedUserData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! LoginModel
                    currentLoginUser = decodedUserData
                    
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
}
