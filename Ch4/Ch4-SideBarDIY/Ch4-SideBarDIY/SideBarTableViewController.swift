//
//  SideBarTableViewController.swift
//  Ch4-SideBarDIY
//
//  Created by Jaeseong on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class SideBarTableViewController: UITableViewController {

    let titles = ["메뉴01",
                  "메뉴02",
                  "메뉴03",
                  "메뉴04",
                  "메뉴05"]
    let icons = [UIImage(named: "icon01.png"),
                 UIImage(named: "icon02.png"),
                 UIImage(named: "icon03.png"),
                 UIImage(named: "icon04.png"),
                 UIImage(named: "icon05.png")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        accountLabel.text = "toygift@naver.com"
        accountLabel.textColor = UIColor.white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = UIColor.brown
        v.addSubview(accountLabel)
        self.tableView.tableHeaderView = v
        
    }
   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let id = "menucell"
//        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        let cell = UITableViewCell()
        
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: id)
//        }
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }

}
