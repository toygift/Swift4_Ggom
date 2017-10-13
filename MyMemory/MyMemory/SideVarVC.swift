//
//  SideVarVC.swift
//  MyMemory
//
//  Created by Jaeseong on 2017. 10. 10..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class SideVarVC: UITableViewController {

    let uinfo = UserInfoManager()
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    
    let titles = ["새글 작성",
                  "친구 새글",
                  "달력으로보기",
                  "공지사항",
                  "통계",
                  "계정관리"]
    let icons = [UIImage(named: "icon01.png"),
                 UIImage(named: "icon02.png"),
                 UIImage(named: "icon03.png"),
                 UIImage(named: "icon04.png"),
                 UIImage(named: "icon05.png"),
                 UIImage(named: "icon06.png")]
    
    // MARK : LIFECYCLE
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.brown
        self.tableView.tableHeaderView = headerView
        // nameLabel
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(self.nameLabel)
        // emailLabel
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        
        self.emailLabel.textColor = UIColor.white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(self.emailLabel)
        
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        view.addSubview(self.profileImage) // ?
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }
    // MARK : TABLEVIEW
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id  = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController().frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController().revealToggle(self)
        } else if indexPath.row == 5 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            self.present(uv!, animated: true, completion: {
                self.revealViewController().revealToggle(self)
            })
        }
    }
    
}
