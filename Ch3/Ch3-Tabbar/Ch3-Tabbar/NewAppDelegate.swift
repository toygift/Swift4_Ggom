//
//  NewAppDelegate.swift
//  Ch3-Tabbar
//
//  Created by Jaeseong Lee on 2017. 10. 7..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit
@UIApplicationMain
class NewAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        self.window?.rootViewController = tbC
        
        let view1 = ViewController()
        let view2 = SecondViewController()
        let view3 = ThirdViewController()
        
        tbC.setViewControllers([view1, view2, view3], animated: false)
        
        view1.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view2.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-tree"), selectedImage: nil)
        view3.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo"), selectedImage: nil)
        
        return true
    }
}
