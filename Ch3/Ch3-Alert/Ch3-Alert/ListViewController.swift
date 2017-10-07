//
//  ListViewController.swift
//  Ch3-Alert
//
//  Created by Jaeseong Lee on 2017. 10. 8..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var delegate: MapAlertViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize.height = 220
        
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)번째 옵션"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
