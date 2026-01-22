//
//  TasksListViewModel.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 22/01/26.
//

import Foundation
import Observation

@Observable
final class TasksListViewModel {
    private let interactor: TasksInteractor
    
    private(set) var tasks: [Tasks] = []
    
    init (interactor: TasksInteractor) {
        self.interactor = interactor
    }

    func loadTasks(_ toDoListId: UUID) {
        tasks = interactor.fetchTasks(toDoListId: toDoListId)
    }
    
    func doneTask(_ task: Tasks) {
        guard let taskRetorno = interactor.editTask(taskId: task.id, task: task) else { return }
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index] = taskRetorno
    }

    func deleteTask(_ task: Tasks) {
        interactor.removeTask(task.id)
    }
}
