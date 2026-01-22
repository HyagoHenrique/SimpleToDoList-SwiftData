//
//  TaskRepositoryProtocol.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import Foundation

protocol TasksRepositoryProtocol {
    func fetchAll(toDoListId: UUID) -> [Tasks]
    func add(_ task: Tasks) -> Tasks
    func edit(_ taskId: UUID, task: Tasks) -> Tasks?
    func delete(_ taskId: UUID) -> Bool
}
