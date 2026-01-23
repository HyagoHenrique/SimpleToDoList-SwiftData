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
                                    .strikethrough(task.done, color: .red)
                                    .foregroundStyle(task.done ? .secondary : .primary)
                            }
                            Text("Vencimento: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                .foregroundStyle(.secondary)
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
            .onAppear() {
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

    func add(_ task: Tasks) {
        tasks.append(task)
    }

    func edit(_ taskId: UUID, task: Tasks) {
        guard let index = tasks.firstIndex(where: {$0.id == taskId }) else { return }
        tasks[index] = task
    }

    func delete(_ taskId: UUID) -> Bool {
        guard let index = tasks.firstIndex(where: {$0.id == taskId }) else { return false }
        tasks.remove(at: index)
        return true
    }
}

