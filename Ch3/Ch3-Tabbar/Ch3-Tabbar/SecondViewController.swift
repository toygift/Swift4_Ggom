//
//  SecondViewController.swift
//  Ch3-Tabbar
//
//  Created by Jaeseong Lee on 2017. 10. 7..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        // 2
        title.text = "두번째 탭"
        title.textColor = UIColor.red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit() // 콘텐츠의 길이에 맞추어 레이블의 크기를 조절해 주는 메소드
        title.center.x = self.view.frame/*.size*/.width/2
        self.view.addSubview(title)

        
    }

}
