//
//  LogVC.swift
//  Ch7-CoreData
//
//  Created by Jaeseong on 2017. 10. 17..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit
import CoreData


public enum LogType: Int16 {
    case create = 0
    case edit = 1
    case delete = 2
}
// Int16 extension
extension Int16 {
    func toLogType() -> String {
        switch self {
        case 0:
            return "생성"
        case 1:
            return "수정"
        case 2:
            return "삭제"
        default:
            return ""
        }
    }
}

class LogVC: UITableViewController {

    var board: BoardMO!
    
    lazy var list: [LogMO]! = {
        return self.board.logs?.array as! [LogMO]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.board.title
       
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
        cell.textLabel?.text = "\(row.regdate!)에 \(row.type.toLogType())되었습니다"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }

}
