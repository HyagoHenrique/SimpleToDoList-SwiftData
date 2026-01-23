//
//  TasksModel.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import SwiftData
import Foundation

@Model
final class TasksModel {
    
    @Attribute(.unique)
    var id: UUID
    
    var title: String
    var done: Bool
    var dueDate: Date
    
    init(id: UUID = UUID(), title: String, done: Bool, dueDate: Date) {
        self.id = id
        self.title = title
        self.done = done
        self.dueDate = dueDate
    }
}
