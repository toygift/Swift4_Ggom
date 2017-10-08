//
//  ViewController.swift
//  Ch3-CustomStepper
//
//  Created by Jaeseong Lee on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let stepper = CSStepper()
        stepper.frame = CGRect(x: 30, y: 100, width: 130, height: 30)
        self.view.addSubview(stepper)
    }
}

