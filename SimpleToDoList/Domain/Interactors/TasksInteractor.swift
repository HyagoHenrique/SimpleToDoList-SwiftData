//
//  TasksInteractor.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import Foundation
import SwiftData

struct TasksInteractor {
    private let repository: TasksRepositoryProtocol
    
    init(repository: TasksRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchTasks() -> [Tasks] {
        repository.fetchAll()
    }

    func addTask(_ task: Tasks) {
        repository.add(task)
    }

    func editTask(taskId: UUID, task: Tasks) -> Tasks? {
        repository.edit(taskId, task: task)
    }

    func removeTask(_ taskId: UUID) -> Bool {
        repository.delete(taskId)
    }
}
