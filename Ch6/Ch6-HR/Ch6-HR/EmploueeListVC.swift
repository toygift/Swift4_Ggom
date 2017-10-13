//
//  EmploueeListVC.swift
//  Ch6-HR
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class EmploueeListVC: UITableViewController {

    var loadingImg: UIImageView!
    var bgCircle: UIView!
    var empList: [EmployeeVO]!
    var empDAO = EmployeeDAO()
    @IBAction func add(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "사원등록", message: "등록할 사원 정보입력", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "사원명"
        }
        let pickervc = DepartPickerVC()
        alert.setValue(pickervc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
            var param = EmployeeVO()
            param.departCd = pickervc.selectedDepartCd
            param.empName = (alert.textFields?[0].text)!
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            param.joinDate = df.string(from: Date())
            param.stateCd = EmpStateType.ING
            
            if self.empDAO.create(param: param) {
                self.empList = self.empDAO.find()
                self.tableView.reloadData()
                
                if let navTitle = self.navigationItem.titleView as? UILabel {
                    navTitle.text = "사원 목록 \n" + "총 \(self.empList.count)명"
                }
            }
        }))
        self.present(alert, animated: false, completion: nil)
    }
    @IBAction func editing(_ sender: UIBarButtonItem) {
//        if self.isEditing == false {
//            self.setEditing(true, animated: true)
//            sender.title = "Done"
//        } else {
//            self.setEditing(false, animated: true)
//            sender.title = "Edit"
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.empList = self.empDAO.find()
        self.initUI()
        self.refreshControl = UIRefreshControl()
//        self.refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        self.loadingImg = UIImageView(image: UIImage(named: "refresh"))
        self.loadingImg.center.x = (self.refreshControl?.frame.width)! / 2
        self.refreshControl?.tintColor = UIColor.clear
        self.refreshControl?.addSubview(self.loadingImg)
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        self.bgCircle = UIView()
        self.bgCircle.backgroundColor = UIColor.yellow
        self.bgCircle.center.x = (self.refreshControl?.frame.width)! / 2
        
        self.refreshControl?.addSubview(self.bgCircle)
        self.refreshControl?.bringSubview(toFront: self.loadingImg)
    }
    @objc func pullToRefresh(_ sender: Any) {
        self.empList = self.empDAO.find()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        UIView.animate(withDuration: 0.5) {
            self.bgCircle.frame.size.width = 80
            self.bgCircle.frame.size.height = 80
            self.bgCircle.center.x = (self.refreshControl?.frame.width)! / 2
            self.bgCircle.center.y = distance / 2
            self.bgCircle.layer.cornerRadius = (self.bgCircle?.frame.size.width)! / 2
            
        }
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        self.loadingImg.center.y = distance / 2
        let ts = CGAffineTransform(rotationAngle: CGFloat(distance / 20))
        self.loadingImg.transform = ts
        self.bgCircle.center.y = distance / 2
    }
   override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.bgCircle.frame.size.width = 0
        self.bgCircle.frame.size.height = 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.empList.count
    }
    // MARK : TABLEVIEW
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = self.empList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL")
        
        cell?.textLabel?.text = rowData.empName + "(\(rowData.stateCd.desc()))"
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.detailTextLabel?.text = rowData.departTitle
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let empCd = self.empList[indexPath.row].empCd
        if empDAO.remove(empCd: empCd) {
            self.empList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func initUI() {
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "사원 목록 \n" + "총 \(self.empList.count)명"
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.allowsSelectionDuringEditing = true
    }
}
