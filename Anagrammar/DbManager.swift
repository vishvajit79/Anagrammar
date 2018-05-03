//
//  DbManager.swift
//  lab9
//
//  Created by Tech on 2018-04-11.
//  Copyright © 2018 Tech. All rights reserved.
//

import Foundation
import SQLite3

class DbManager{
    var db: OpaquePointer?
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Practice.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("Error opening database")
        }
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Items (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, score INTEGER)"
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error creating table")
        }
    }
    
    deinit {
        if sqlite3_close(db) != SQLITE_OK{
            print("Error closing database")
            return
        }
        print("database closed")
        db = nil
    }
    
    func selectAll()->[(id:Int, name:String, score: Int)]{
        var dataList = [(id: Int, name: String, score: Int)]()
        dataList.removeAll()
        let query = "SELECT * FROM Items"
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db))
            print("Error selecting from table: \(err)")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW{
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let score = sqlite3_column_int(stmt, 2)
            dataList.append((id: Int(id), name: String(describing: name), score: Int(score)))
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(db))
            print("Error finalizing statement: \(err)")
        }
        stmt = nil
        return dataList
    }
    
    func insertItem(name:String, score: Int){
        print("######################## \(name) \(score)")
        var stmt: OpaquePointer?
        let query = "INSERT INTO Items (name, score) VALUES (?, ?)"
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 2, Int32(score)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error inserting item: \(errmsg)")
            return
        }
        stmt = nil
    }
    
}
