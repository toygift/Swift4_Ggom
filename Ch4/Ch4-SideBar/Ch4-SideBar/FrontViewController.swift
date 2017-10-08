//
//  FrontViewController.swift
//  Ch4-SideBar
//
//  Created by Jaeseong on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet var sideBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let revealVC = self.revealViewController() {
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
        
        
    }
}
