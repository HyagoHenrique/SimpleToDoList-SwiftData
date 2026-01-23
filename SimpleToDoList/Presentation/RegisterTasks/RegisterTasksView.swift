//
//  RegisterTasksView.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 22/01/26.
//

import SwiftUI

struct RegisterTasksView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: RegisterTasksViewModel
    
    init(viewModel: RegisterTasksViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            DatePicker("Vencimento:", selection: $viewModel.task.dueDate, in: Date()..., displayedComponents: .date)
            TextField("Nome da tarefa", text: $viewModel.task.title)
                .padding(12)
                .background(Capsule().fill(Color(.systemGray5)))
            Text("O nome da tarefa não pode ser vazio")
                .foregroundStyle(Color.red)
                .padding(.top, 20)
                .opacity(viewModel.warning ? 1 : 0)
        }
        .padding(.horizontal, 30)
        .navigationBarTitle(viewModel.navigationTitle)
        .navigationBarItems(trailing: Button("Salvar") {
            viewModel.saveTask()
            dismiss()
        })
    }
}

#Preview {
    let repository = FakeTasksRepository()
    let interactor = TasksInteractor(repository: repository)
    let viewModel = RegisterTasksViewModel(interactor: interactor, .create)
    RegisterTasksView(viewModel: viewModel)
}

