//
//  TasksInteractor.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import Foundation

struct TasksInteractor {
    private let repository: TasksRepositoryProtocol
    
    init(repository: TasksRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchTasks(toDoListId: UUID) -> [Tasks] {
        repository.fetchAll(toDoListId: toDoListId)
    }

    func addTask(_ task: Tasks) -> Tasks {
        repository.add(task)
    }

    func editTask(toDoListId: UUID, task: Tasks) -> Tasks? {
        repository.edit(toDoListId, task: task)
    }
}
