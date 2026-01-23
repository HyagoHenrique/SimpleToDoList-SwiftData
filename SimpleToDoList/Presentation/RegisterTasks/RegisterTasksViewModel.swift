//
//  RegisterTasksViewModel.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 22/01/26.
//

import Observation
import Combine
import Foundation

@Observable
final class RegisterTasksViewModel {
    var task: Tasks
    
    init(_ task: Tasks?, toDoListId: UUID) {
        self.task = task ?? Tasks(id: UUID(), toDoListId: toDoListId, title: "", done: false, dueDate: Date())
    }


    func saveTask() {
        if task.title.isEmpty {
            return
        }
        
        // TODO: SaveTask.
    }
}

