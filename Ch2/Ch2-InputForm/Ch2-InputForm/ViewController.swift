//
//  ViewController.swift
//  Ch2-InputForm
//
//  Created by Jaeseong Lee on 2017. 10. 7..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var paramEmail: UITextField!
    var paramUpdate: UISwitch!
    var paramInterval: UIStepper!
    var txtUpdate: UILabel!
    var txtInterval: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 네비게이션바 타이틀
        self.navigationItem.title = "설정"
        
        // 2. 이메일레이블
        let labelEmail = UILabel()
        labelEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        labelEmail.text = "이메일"
        labelEmail.font = UIFont.systemFont(ofSize: 14)
        //labelEmail.font = UIFont(name: "Chalkboard SE", size: 14) -> 폰트의 종류까지 지정하고자 할 경우
        self.view.addSubview(labelEmail)
        // 3. 갱신레이블
        let labelUpdate = UILabel()
        labelUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        labelUpdate.text = "자동갱신"
        labelUpdate.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(labelUpdate)
        // 4. 갱신주기 레이블
        let labelInterval = UILabel()
        labelInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        labelInterval.text = "갱신주기"
        labelInterval.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(labelInterval)
        // 5. 이메일텍스트필드
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextBorderStyle.roundedRect
        self.paramEmail.autocapitalizationType = .none
        self.view.addSubview(self.paramEmail)
        // 6. 스위치
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(self.paramUpdate)
        // 7. 스테퍼
        self.paramInterval = UIStepper()
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0
        self.paramInterval.maximumValue = 100
        self.paramInterval.stepValue = 1
        self.paramInterval.value = 0
        self.view.addSubview(self.paramInterval)
        // 8. 스테퍼 레이블
        self.txtUpdate = UILabel()
        self.txtUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.textColor = UIColor.red
        self.txtUpdate.text = "갱신함"
        self.view.addSubview(self.txtUpdate)
        // 9. 스테퍼값 레이블
        self.txtInterval = UILabel()
        self.txtInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        self.view.addSubview(self.txtInterval)
        
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
    }
    @objc func presentUpdateValue(_ sender: UISwitch) {
        self.txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    @objc func presentIntervalValue(_ sender: UIStepper) {
        self.txtInterval.text = ("\(Int(sender.value))분마다")
    }
}

