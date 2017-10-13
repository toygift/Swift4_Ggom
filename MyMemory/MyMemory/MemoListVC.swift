//
//  MemoListVC.swift
//  MyMemory
//
//  Created by Jaeseong Lee on 2017. 10. 6..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let revealVC = self.revealViewController() {
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            self.navigationItem.leftBarButtonItem = btn
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorailVC(name: "MasterVC")
            self.present(vc!, animated: false, completion: nil)
            return
        }
        self.tableView.reloadData()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.appDelegate.memolist[indexPath.row]
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
     
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.regdate?.text = formatter.string(from: row.regdate!) //regdate는 Date()로 초기화 했으므로
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.memolist[indexPath.row]
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else { return }
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
