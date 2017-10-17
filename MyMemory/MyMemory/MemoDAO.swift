//
//  MemoDAO.swift
//  MyMemory
//
//  Created by Jaeseong on 2017. 10. 17..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import Foundation
import CoreData

class MemoDAO {
    // 관리객체컨텍스트를 반환하는 변수
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // 저장된 메모를 불러오는 함수
    func fetch(keyword text: String? = nil) -> [MemoData] {
        var memolist = [MemoData]()
        
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        if let t = text, t.isEmpty == false {
            fetchRequest.predicate = NSPredicate(format: "contents CONTAINS[c] %@", t)
        }
        
        do {
            let resultset = try self.context.fetch(fetchRequest)
            
            for record in resultset {
                let data = MemoData()
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate
                data.objectID = record.objectID
                
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                memolist.append(data)
            }
        } catch let e as NSError {
            NSLog("An error has occurred : %s", e.localizedDescription)
        }
        return memolist
    }
    // 새 메모를 저정하는 함수
    func insert(_ data: MemoData) {
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as! MemoMO
        object.title = data.title
        object.contents = data.contents
        object.regdate = data.regdate
        
        if let image = data.image {
            object.image = UIImagePNGRepresentation(image)!
        }
        do {
            try self.context.save()
        } catch let e as NSError {
            NSLog("An Error has occurred : %s", e.localizedDescription)
        }
    }
    // 메모를 삭제하는 함수
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        
        do {
            try self.context.save()
            return true
        } catch let e as NSError {
            NSLog("An Error has occurred : %s", e.localizedDescription)
            return false
        }
    }
}

