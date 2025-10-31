//
//  Router.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUICore

enum Screen: Hashable {
    case taskListScreenView
    case taskEditScreenView(task: TaskModel)
}

extension Screen: View {
    var body: some View {
        switch self {
        case .taskListScreenView:
            TaskListScreenView()
        case .taskEditScreenView(let task):
            TaskEditScreenView(task: task)
        }
    }
}

final class NavigationRouter: ObservableObject {
    @Published var screens = [Screen]()
    
    func go(to screen: Screen) {
        screens.append(screen)
    }
    
    func reset() {
        screens = []
    }
    
    func navigateBack() {
        _ = screens.popLast()
    }
}

