//
//  TaskListLongPressActionsView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct TaskListLongPressActionsView: View {
    
    @EnvironmentObject var router: NavigationRouter
    
    let task: TaskModel
    
   var deleteAction: () -> Void
    
    var body: some View {
        VStack {
            Button("Edit") {
                router.go(to: .taskEditScreenView(task: task))
            }
            
            Button("Delete", role: .destructive) {
                // Perform delete action
                deleteAction()
            }
            ShareLink(item: task.todo ?? "") {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
    }
}

#Preview {
    TaskListLongPressActionsView(task: TaskModel(id: 1, todo: "gogo", completed: false, userId: 33), deleteAction: {})
        .environmentObject(NavigationRouter())
}

//task: TaskModel(id: 1, todo: "gogo", completed: false, userId: 33)
