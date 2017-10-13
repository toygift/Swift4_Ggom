//
//  TutorialMasterVCViewController.swift
//  MyMemory
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class TutorialMasterVCViewController: UIViewController, UIPageViewControllerDataSource {

    var pageVC: UIPageViewController!
    var contentsTitles = ["STEP 1","STEP 2","STEP 3","STEP 4"]
    var contentsImages = ["Page0","Page1","Page2","Page3"]
    @IBAction func close(_ sender: UIButton) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    // MARK : LIFECYCLE
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageVC = self.instanceTutorailVC(name: "PageVC") as! UIPageViewController
        self.pageVC.dataSource = self
        
        let startContentVC = self.getContentVC(atIndex: 0)!
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true, completion: nil)
        self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        self.addChildViewController(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParentViewController: self)
        
    }
    // MARK : FUNC
    //
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        guard self.contentsTitles.count >= idx && self.contentsTitles.count > 0 else {
            return nil
        }
        guard let cvc = self.instanceTutorailVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        cvc.titleText = self.contentsTitles[idx]
        cvc.imageFile = self.contentsImages[idx]
        cvc.pageIndex = idx
        return cvc
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        guard index > 0 else {
            return nil
        }
        index -= 1
        return self.getContentVC(atIndex: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        index += 1
        
        guard index < self.contentsTitles.count else {
            return nil
        }
        return self.getContentVC(atIndex: index)
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentsTitles.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
