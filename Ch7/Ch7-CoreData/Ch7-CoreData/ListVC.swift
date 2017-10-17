//
//  ListVC.swift
//  Ch7-CoreData
//
//  Created by Jaeseong on 2017. 10. 17..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit
import CoreData

class ListVC: UITableViewController {
    
    
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
        
        
    }
    // #selector add(_:)
    @objc func add(_ sender: Any) {
        let alert = UIAlertController(title: "게시글등록", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "제목"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "내용"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction((UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            if self.save(title: title, contents: contents) == true {
                self.tableView.reloadData()
            }
        })))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        if self.delete(object: object) {
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글수정", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.text = title
        }
        alert.addTextField { (tf) in
            tf.text = contents
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            if self.edit(object: object, title: title, contents: contents) == true {
//                self.tableView.reloadData()
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                let firstIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexPath)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogVC") as! LogVC
        uvc.board = object as! BoardMO
        self.show(uvc, sender: self)
    }
    // MARK: - CoreDate
    
    // 코어데이터에서 데이터를 가져오기
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let result = try! context.fetch(fetchRequest)
        return result
    }
    // 코어데이터에 데이터를 저정하기
    func save(title: String, contents: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue
        (object as! BoardMO).addToLogs(logObject)
        
        do {
            try context.save()
//            self.list.append(object)
            self.list.insert(object, at: 0)
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    // 코어데이터의 데이터를 삭제하기
    // 컨텍스트로부터 객체를 삭제하고, save() 호출
    func delete(object: NSManagedObject) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // 컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        // 영구저장소에 커밋(동기화)
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    // 코어데이터의 데이터를 수정하기
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue
        (object as! BoardMO).addToLogs(logObject)
        
        // 영구저장소에 저장
        do {
            try context.save()
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    
    
}
