//
//  ViewController.swift
//  Ch3-CustomButton
//
//  Created by Jaeseong Lee on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let frame = CGRect(x: 30, y: 50, width: 150, height: 30)
//        let csBtn = CSButton(frame: frame)
//        self.view.addSubview(csBtn)
//        
        let csBtns = CSButton()
        csBtns.frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        self.view.addSubview(csBtns)
        
        let rectBtn = CSButton(type: .rect)
        rectBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        circleBtn.style = .rect
    }


}

