//
//  CSButton.swift
//  Ch3-CustomButton
//
//  Created by Jaeseong Lee on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit


public enum CSButtonType {
    case rect
    case circle
}

class CSButton: UIButton {

    var style: CSButtonType = .rect {
        didSet { // 프로퍼티 옵저버
            switch style {
                case .rect:
                self.backgroundColor = UIColor.black
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 0
                self.setTitleColor(UIColor.white, for: .normal)
                self.setTitle("Rect Button", for: .normal)
            case .circle:
                self.backgroundColor = UIColor.red
                self.layer.borderColor = UIColor.blue.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 50
                self.setTitle("Circle Button", for: .normal)
            }
        }
    }
    
    // 1
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = UIColor.green
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitle("버튼", for: .normal)
        
        }
    // 2
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.setTitle("코드로 생성된 버튼", for: .normal)
        
    }
    // 3
    init() {
        super.init(frame: CGRect.zero) // 0.0.0.0
//        self.backgroundColor = UIColor.gray
    }
    // 4
    convenience init(type: CSButtonType) {
        self.init() // frame: CGRect.zero
        self.addTarget(self, action: #selector(counting(_:)), for: .touchUpInside)
        switch type {
        case .rect:
            self.backgroundColor = UIColor.black
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitle("Rect Button", for: .normal)
        case .circle:
            self.backgroundColor = UIColor.red
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 50
            self.setTitle("Circle Button", for: .normal)
        }
    }
    
    @objc func counting(_ sender: UIButton) {
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag)번째 클릭", for: .normal)
    }
}
