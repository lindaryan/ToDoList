//
//  DatabaseHelper.swift
//  ToDoList
//
//  Created by Linda Ryan on 2020-11-13.
//  Copyright © 2020 Linda Ryan. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    let db: Connection?
    let items = Table("items")
    let id = Expression<Int64>("id")
    let description = Expression<String>("description")
    let isCompleted = Expression<Bool>("isCompleted")
    let dateAdded = Expression<Date>("dateAdded")
    let dateCompleted = Expression<Date?>("dateCompleted")
    
    init() {
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/itemsDb.sqlite3")
            print(path)
            createItemsTable()
        } catch(let message) {
            print(message)
            db = nil
        }
    }
    
    private func createItemsTable() {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        
        do {
            try db!.run(items.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(description)
                t.column(isCompleted, defaultValue: false)
                t.column(dateAdded)
                t.column(dateCompleted)
            })
            // update
           // try db!.run(items.addColumn(dateCompleted))
        }
        catch(let message) {
            print(message)
        }
    }
    
    func insertItem(item:ToDoItem) {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        
        let insert = items.insert(
            description <- item.description,
            isCompleted <- item.completed,
            dateAdded <- item.dateCreated,
            dateCompleted <- item.dateCompleted
        )
        
        do {
            let id = try db!.run(insert)
            item.assignIdOnInsert(id: Int64(Int(id)))
            
        } catch(let message) {
            print(message)
        }
    }
    
    func getItems() -> [ToDoItem]? {
        if(db == nil) {
            print("Unable to get connected")
            return nil
        }
        
        do {
            var toDoItems: [ToDoItem] = [ToDoItem]()
            
            for row in try db!.prepare(items) {
                let item = ToDoItem(
                    description: row[description],
                    isCompleted: row[isCompleted],
                    dateCreated: row[dateAdded],
                    id: row[id],
                    dateCompleted: row[dateCompleted] ?? Date()
                )
                toDoItems.append(item)
            }
            
            return toDoItems
            
        } catch(let message) {
            print(message)
            return nil
        }
    }
    
    func completeItem(item: ToDoItem) {
        if (db == nil) {
            print("Unable to get connection")
            return
        }
        
        let dbItem = items.filter(id == item.id)
    
        do {
            if try db!.run(dbItem.update([isCompleted <- item.completed, dateCompleted <- item.dateCompleted])) > 0 {
                print("Updated successfully.")
            } else {
                print("No item found.")
            }
        } catch (let message) {
            print(message)
        }
    }
}
