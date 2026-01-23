//
//  TasksMapper.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import Foundation

enum TasksMapper {
    static func toDomain(_ model: TasksModel) -> Tasks {
        Tasks(
            id: model.id,
            title: model.title,
            done: model.done,
            dueDate: model.dueDate)
    }

    static func toModel(_ task: Tasks) -> TasksModel {
        TasksModel(
            id: task.id,
            title: task.title,
            done: task.done,
            dueDate: task.dueDate
        )
    }
}
