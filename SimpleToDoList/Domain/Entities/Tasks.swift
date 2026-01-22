//
//  Tasks.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//
import Foundation

struct Tasks {
    let id: UUID
    let toDoListId: UUID
    let title: String
    let done: Bool
    let dueDate: Date
}
