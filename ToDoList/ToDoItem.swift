//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Linda Ryan on 2020-11-05.
//  Copyright © 2020 Linda Ryan. All rights reserved.
//

import Foundation

class ToDoItem {
    let description: String
    let dateCreated: Date
    var completed: Bool
    var id: Int64
    var dateCompleted: Date

    init(description: String) {
        self.description = description
        self.dateCreated = Date()
        self.completed = false
        self.id = 0
        self.dateCompleted = Date()
    }
    
    init(description: String, isCompleted: Bool, dateCreated: Date, id: Int64, dateCompleted: Date) {
        self.description = description
        self.dateCreated = dateCreated
        self.completed = isCompleted
        // create id for db item insert
        self.id = id
        self.dateCompleted = dateCompleted
    }
    
    func completeItem() {
        self.completed = true
    }
    
    // for a5 db insert
    // on item insert assign value to id
    func assignIdOnInsert(id: Int64) {
        self.id = id
    }
    
    func dateCreatedAsString() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self.dateCreated)
    }
    
    func dateCompletedAsString() -> String {
        // format dates as specified in date format string
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat

        // return date value converted to string
        return dateFormatter.string(from: self.dateCompleted)
    }
}
