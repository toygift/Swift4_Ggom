//
//  ViewController.swift
//  Ch6-SQLite3
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
        
    }
    // MARK : FUNC
    //
    func getDBPath() -> String {
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("db.sqlite").path
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        return dbPath
    }
    func dbExecute(dbPath: String) {
        var db: OpaquePointer? = nil
        
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("DataBase Connect Fail")
            return
        }
        defer {
            print("Close Database Connection")
            sqlite3_close(db)
        }
        
        var stmt: OpaquePointer? = nil
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK  else {
            print("Prepare Statement Fail")
            return
        }
        defer {
            print("Finalize Statement")
            sqlite3_finalize(stmt)
        }
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Create Table Success!")
        }
    }
}

