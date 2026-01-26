//
//  SimpleToDoListApp.swift
//  SimpleToDoList
//
//  Created by Hyago Henrique on 21/01/26.
//

import SwiftUI
import SwiftData

@main
struct SimpleToDoListApp: App {
    private let container: ModelContainer
    private let factory: AppFactory
    
    init() {
        container = try! ModelContainer(for: TasksModel.self)
        factory = AppFactory(container: container)

    }

    var body: some Scene {
        WindowGroup {
            factory.makeTaskListView()
        }
        .modelContainer(container)
    }
}
