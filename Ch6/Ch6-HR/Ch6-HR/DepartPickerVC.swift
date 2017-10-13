//
//  DepartPickerVC.swift
//  Ch6-HR
//
//  Created by Jaeseong on 2017. 10. 14..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class DepartPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let departDAO = DepartmentDAO()
    var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
    var pickerView: UIPickerView!
    
    var selectedDepartCd: Int {
        let row = self.pickerView.selectedRow(inComponent: 0)
        return self.departList[row].departCd
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.departList = self.departDAO.find()
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.view.addSubview(self.pickerView)
        
        let pWidth = self.pickerView.frame.width
        let pHeight = self.pickerView.frame.height
        self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
    }
    
    // MARK : PICKERVIEW
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.departList.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var titleView = view as? UILabel
        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: 14)
            titleView?.textAlignment = .center
        }
        titleView?.text = "\(self.departList[row].departTitle)(\(self.departList[row].departAddr))"
        return titleView!
    }
    
}

