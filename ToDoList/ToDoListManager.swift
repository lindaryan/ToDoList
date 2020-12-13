//
//  ToDoListManager.swift
//  ToDoList
//
//  Created by Linda Ryan on 2020-11-13.
//  Copyright © 2020 Linda Ryan. All rights reserved.
//

import Foundation

class ToDoListManager {
    let databaseHelper: DatabaseHelper
    
    init() {
        databaseHelper = DatabaseHelper()
    }
    
    func getItems() -> [ToDoItem] {
        return self.databaseHelper.getItems() ?? [ToDoItem]()
    }
    
    func count() -> Int {
        return self.getItems().count
    }
    
    func addItem(item: ToDoItem) {
        self.databaseHelper.insertItem(item: item)
    }
}
