//
//  AppDelegate.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            let initialViewController = UINavigationController.init(rootViewController: HomeViewController(homeViewModel: HomeViewModelImp()))
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = initialViewController
            return true
        }

}

