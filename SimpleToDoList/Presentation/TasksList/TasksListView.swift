//
//  TasksListView.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 22/01/26.
//

import SwiftUI

struct TasksListView: View {
    @State private var viewModel: TasksListViewModel
    @State private var newTaskTitle = ""
    
    init(viewModel: TasksListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tasks, id: \.id) { task in
                    HStack {
                        Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                viewModel.doneTask(task)
                            }
                        Text(task.title)
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.tasks[$0] }
                        .forEach(viewModel.deleteTask)
                }
            }
        }
        .navigationTitle("Tarefas")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {

                }
            }
        }
    }
}
