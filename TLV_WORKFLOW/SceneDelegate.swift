//
//  SceneDelegate.swift
//  TLV_WORKFLOW
//
//  Created by Harsh Kundariya on 27/10/20.
//  Copyright © 2020 eSparkBiz. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        checkLogin()
    }

    func checkLogin() {
        var nav : UINavigationController?
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.VCIdentifier.splashVC) as! SplashVC
        nav = UINavigationController(rootViewController: vc)
        nav?.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

