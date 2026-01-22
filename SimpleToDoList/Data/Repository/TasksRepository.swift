//
//  TasksRepository.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import SwiftData
import Foundation

final class TasksRepository: TasksRepositoryProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    @MainActor
    func fetchAll(toDoListId: UUID) -> [Tasks] {
        let descriptor = FetchDescriptor<TasksModel>(
            sortBy: [SortDescriptor(\.title)]
        )
        
        let models = (try? context.fetch(descriptor)) ?? []
        return models.map(TasksMapper.toDomain)
    }

    func add(_ task: Tasks) -> Tasks {
        let model = TasksMapper.toModel(task)
        context.insert(model)
        return task
    }
    
    func edit(_ taskId: UUID, task: Tasks) -> Tasks? {
        let descriptor = FetchDescriptor<TasksModel>(
            predicate: #Predicate { $0.id == taskId }
        )
        
        guard let model = try? context.fetch(descriptor).first else {
            fatalError("Task not found")
        }

        model.title = task.title
        model.done = task.done
        model.dueDate = task.dueDate
        return task
    }
    
    func delete(_ taskId: UUID) -> Bool {
        let descriptor = FetchDescriptor<TasksModel>(
            predicate: #Predicate { $0.id == taskId }
        )
        
        guard let model = try? context.fetch(descriptor).first else {
            fatalError("Task not found")
        }
        
        context.delete(model)
        return true
    }
}

