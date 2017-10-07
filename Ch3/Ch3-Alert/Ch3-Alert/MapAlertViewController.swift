//
//  MapAlertViewController.swift
//  Ch3-Alert
//
//  Created by Jaeseong Lee on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        let alertBtn = UIButton(type: .system)
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width/2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert(_:)), for: .touchUpInside)
        self.view.addSubview(alertBtn)
        
        // 2
        let imageBtn = UIButton(type: .system)
        imageBtn.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
        imageBtn.center.x = self.view.frame.width/2
        imageBtn.setTitle("Image Alert", for: .normal)
        imageBtn.addTarget(self, action: #selector(imageAlert(_:)), for: .touchUpInside)
        self.view.addSubview(imageBtn)
        
        // 3
        let sliderBtn = UIButton(type: .system)
        sliderBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
        sliderBtn.center.x = self.view.frame.width/2
        sliderBtn.setTitle("Slider Alert", for: .normal)
        sliderBtn.addTarget(self, action: #selector(sliderAlert(_:)), for: .touchUpInside)
        self.view.addSubview(sliderBtn)
        
        // 4
        let listBtn = UIButton(type: .system)
        listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
        listBtn.center.x = self.view.frame.width/2
        listBtn.setTitle("List Alert", for: .normal)
        listBtn.addTarget(self, action: #selector(listAlert(_:)), for: .touchUpInside)
        self.view.addSubview(listBtn)
    }
    
    // 1
    @objc func mapAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "여기 맞나요?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        //
        let contentVC = MapKitViewController()
        
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: false, completion: nil)
    }
    // 2
    @objc func imageAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "평점은?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        //
        let contentVC = ImageViewController()
        
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        
        self.present(alert, animated: false, completion: nil)
    }
    // 3
    @objc func sliderAlert(_ sender: UIButton) {
        let contentVC = ControlViewController()
        
        let alert = UIAlertController(title: nil, message: "평점은?", preferredStyle: .alert)
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            print(">>> sliderValue = \(contentVC.sliderValue)")
        }
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }
    // 4
    @objc func listAlert(_ sender: UIButton) {
        let contentVC = ListViewController()
        contentVC.delegate = self
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.setValue(contentVC, forKeyPath: "contentViewController")
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }

    // delegate
    func didSelectRowAt(indexPath: IndexPath) {
        print(">>> 선택된 행은 \(indexPath.row)입니다")
    }
    
}
