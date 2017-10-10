//
//  ListTableViewController.swift
//  Ch5-UserDefaults
//
//  Created by Jaeseong on 2017. 10. 10..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var married: UISwitch!
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        let plist = UserDefaults.standard
        plist.set(value, forKey: "gender")
        plist.synchronize()
    }
    @IBAction func chanfeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        let plist = UserDefaults.standard
        plist.set(value, forKey: "married")
        plist.synchronize()
    }
    @IBAction func edit(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "이름을 입력", preferredStyle: .alert)
        alert.addTextField() {
            $0.text = self.name.text
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let value = alert.textFields?[0].text
            let plist = UserDefaults.standard
            plist.setValue(value, forKey: "name")
            plist.synchronize()
            self.name.text = value
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plist = UserDefaults.standard
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let alert = UIAlertController(title: nil, message: "이름을 입력", preferredStyle: .alert)
//            alert.addTextField() {
//                $0.text = self.name.text
//            }
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
//                let value = alert.textFields?[0].text
//                let plist = UserDefaults.standard
//                plist.setValue(value, forKey: "name")
//                plist.synchronize()
//                self.name.text = value
//            }))
//            self.present(alert, animated: false, completion: nil)
//        }
    }
}
