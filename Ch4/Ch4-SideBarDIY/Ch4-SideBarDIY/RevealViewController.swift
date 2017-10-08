//
//  RevealViewController.swift
//  Ch4-SideBarDIY
//
//  Created by Jaeseong on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {

    var contentVC: UIViewController?
    var sideVC: UIViewController?
    var isSideBarShowing = false
    let SLIDE_TIME = 0.3
    let SIDEBAR_WIDTH: CGFloat = 260
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            self.contentVC = vc
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    func getSideView() {
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") {
                self.sideVC = vc
                self.addChildViewController(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParentViewController: self)
                self.view.bringSubview(toFront: (self.contentVC?.view)!)
            }
        }
    }
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if (shadow == true) {
            self.contentVC?.view.layer.cornerRadius = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    func openSideBar(_ complete: ( () -> Void)? ) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        let options = UIViewAnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),
                       delay: TimeInterval(0),
                       options: options,
                       animations: {
            self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        },
                       completion: {
            if $0 == true {
                self.isSideBarShowing = true
                complete?()
            }
        })
    }
    func closeSideBar(_ complete: ( () -> Void)? ) {
        let options = UIViewAnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),
                       delay: TimeInterval(0),
                       options: options,
                       animations: {
                        self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        },
                       completion: {
                        if $0 == true {
                            self.sideVC?.view.removeFromSuperview()
                            self.sideVC = nil
                            self.isSideBarShowing = false
                            self.setShadowEffect(shadow: false, offset: 0)
                            complete?()
                        }
        })
    }
}
