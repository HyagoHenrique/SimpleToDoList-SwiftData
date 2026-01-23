//
//  RegisterTasksViewModel.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 22/01/26.
//

import Observation
import Combine
import Foundation

enum RegisterTasksMode {
    case create
    case edit(Tasks)
}

@Observable
final class RegisterTasksViewModel {
    var task: Tasks
    private let interactor: TasksInteractor
    private(set) var warning: Bool = false
    private let mode: RegisterTasksMode
    
    var navigationTitle: String {
        switch mode {
        case .create:
            return "Nova Tarefa"
        case .edit:
            return "Editar Tarefa"
        }
    }
    
    init(interactor: TasksInteractor, _ mode: RegisterTasksMode) {
        self.interactor = interactor
        self.mode = mode
        
        switch mode {
            case .create:
            self.task = Tasks(id: UUID(), title: "", done: false, dueDate: Date())
        case .edit(let task):
            self.task = task
        }
    }


    func saveTask() {
        let trimmed = task.title.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            warning = true
            return
        }
        
        switch mode {
            case .create:
            task.title = trimmed
            interactor.addTask(task)
            return
            case .edit:
            let updatedTask = Tasks(id: task.id, title: trimmed, done: task.done, dueDate: task.dueDate)
            _ = interactor.editTask(taskId: task.id, task: updatedTask)
            return
        }
    }
}

