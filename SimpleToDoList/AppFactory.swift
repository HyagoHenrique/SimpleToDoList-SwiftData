//
//  AppFactory.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 23/01/26.
//

import Foundation
import SwiftData

final class AppFactory {
    private let container: ModelContainer
    private let context: ModelContext

    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }

    func makeTaskListView() -> TasksListView {
        let repository = TasksRepository(context: context)
        let interactor = TasksInteractor(repository: repository)
        let viewModel = TasksListViewModel(interactor: interactor)
        return TasksListView(viewModel: viewModel, factory: self)
    }

    func makeRegisterTasksView(_ task: Tasks? = nil) -> RegisterTasksView {
        let repository = TasksRepository(context: context)
        let interactor = TasksInteractor(repository: repository)
        guard let editTask = task else {
            let viewModel = RegisterTasksViewModel(interactor: interactor, .create)
            return RegisterTasksView(viewModel: viewModel)
        }
        let viewModel = RegisterTasksViewModel(interactor: interactor, .edit(editTask))
        return RegisterTasksView(viewModel: viewModel)
    }
}
