//
//  DepartmentListVC.swift
//  Ch6-HR
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class DepartmentListVC: UITableViewController {

    var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
    let departDAO = DepartmentDAO()
    @IBAction func add(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "신규부서등록", message: "신규부서를 등록해주세요", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "부서명"
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "주소"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
            let title = alert.textFields?[0].text
            let addr = alert.textFields?[1].text
            
            if self.departDAO.create(title: title!, addr: addr!) {
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "부서 목록 \n" + "총 \(self.departList.count) 개"
            }
        }))
        self.present(alert, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.departList = self.departDAO.find()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.departList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = self.departList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
        
        cell?.textLabel?.text = rowData.departTitle
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell?.detailTextLabel?.text = rowData.departAddr
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let departCd = self.departList[indexPath.row].departCd
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "DEPART_INFO")
        if let _infoVC = infoVC as? DepartmentInfoVC {
            _infoVC.departCd = departCd
            self.navigationController?.pushViewController(_infoVC, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let departCd = self.departList[indexPath.row].departCd
        if departDAO.remove(depratCd: departCd) {
            self.departList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK : FUNC
    //
    func initUI() {
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서목록 \n" + "총 \(self.departList.count) 개"
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.allowsSelectionDuringEditing = true
    }
    
}
