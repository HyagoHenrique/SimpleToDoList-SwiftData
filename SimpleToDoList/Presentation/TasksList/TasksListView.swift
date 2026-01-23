//
//  TasksListView.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 22/01/26.
//

import SwiftUI

struct TasksListView: View {
    @State private var viewModel: TasksListViewModel
    private let factory: AppFactory?

    init(viewModel: TasksListViewModel, factory: AppFactory? = nil) {
        _viewModel = State(initialValue: viewModel)
        self.factory = factory
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tasks, id: \.id) { task in
                    NavigationLink {
                        factory?.makeRegisterTasksView(task)
                    } label: {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(.green)
                                    .onTapGesture {
                                        viewModel.doneTask(task)
                                    }
                                Text(task.title)
                            }
                            Text("Vencimento: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                        }
                        .onTapGesture {
                            
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.tasks[$0] }
                        .forEach(viewModel.deleteTask)
                }
            }
            .navigationTitle("Tarefas")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink {
                        factory?.makeRegisterTasksView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                viewModel.loadTasks()
            }
        }
    }
}

#Preview {
    // Provide a simple mock view model for preview purposes
    let repository = FakeTasksRepository()
    let interactor = TasksInteractor(repository: repository)
    let viewModel = TasksListViewModel(interactor: interactor)
    TasksListView(viewModel: viewModel)
}

// MARK: - Fake Repository for preview

final class FakeTasksRepository: TasksRepositoryProtocol {
    private(set) var tasks: [Tasks] = [
        Tasks(id: UUID(), title: "Fazer compras", done: false, dueDate: Date()),
        Tasks(id: UUID(), title: "Estudar SwiftUI", done: true, dueDate: Date()),
        Tasks(id: UUID(), title: "Assistir a um episódio de Breaking Bad", done: false, dueDate: Date())
    ]

    func fetchAll() -> [Tasks] {
        return tasks
    }

    func add(_ task: Tasks) -> Tasks {
        tasks.append(task)
        return task
    }

    func edit(_ taskId: UUID, task: Tasks) -> Tasks? {
        guard let index = tasks.firstIndex(where: {$0.id == taskId }) else { return nil }
        tasks[index] = task
        return tasks[index]
    }

    func delete(_ taskId: UUID) -> Bool {
        guard let index = tasks.firstIndex(where: {$0.id == taskId }) else { return false }
        tasks.remove(at: index)
        return true
    }
}
