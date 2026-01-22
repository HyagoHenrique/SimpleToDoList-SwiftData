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
    
    init() {
        container = try! ModelContainer(for: TasksModel.self)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
