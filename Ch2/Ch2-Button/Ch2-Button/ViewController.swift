//
//  ViewController.swift
//  Ch2-Button
//
//  Created by Jaeseong Lee on 2017. 10. 7..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        btn.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        btn.setTitle("테스트버튼", for: .normal)
        self.view.addSubview(btn)
     
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
    }

    @objc func btnOnClick(_ sender: UIButton) {
        sender.setTitle("클릭되었습니다.", for: .normal)
    }
}

