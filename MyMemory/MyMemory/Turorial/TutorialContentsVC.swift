//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class TutorialContentsVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bgImageView: UIImageView!
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        self.bgImageView.image = UIImage(named: self.imageFile)
        
    }
}
