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

    func loadTasks() {
        tasks = interactor.fetchTasks()
    }
    
    func doneTask(_ task: Tasks) {
        let taskEdit = Tasks(id: task.id, title: task.title, done: !task.done, dueDate: task.dueDate)
        interactor.editTask(taskId: task.id, task: taskEdit)
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index] = taskEdit
    }

    func deleteTask(_ task: Tasks) {
        if interactor.removeTask(task.id) {
            tasks.removeAll(where: { $0.id == task.id })
        }
    }
}
