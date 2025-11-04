//
//  TaskListScreenView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

// MARK: Список Задач

import SwiftUI

struct TaskListScreenView: View {

    @StateObject var presenter = TaskListPresenter()
    @Binding var isDarkEnabled: Bool
    
    var body: some View {
        if (presenter.filteredItems.count == 0) {
            Text("Упс, задач не найдено")
                .font(.title2)
        }
        ZStack(alignment: .bottom) {
            List {
                ForEach(presenter.filteredItems.indices, id: \.self) { i in
                    // Row View
                    ListRowView(headerText: presenter.header(of: i), taskText: presenter.tasksList[i].todo ?? "", date: presenter.tasksList[i].dateCreated?.formatted() ?? Date().formatted(), isShowDivider: i == 0, completed: presenter.tasksList[i].completed)
                    .onTapGesture {
                        // Check task as done
                        presenter.checkAsDone(at: i)
                    }
                    .contextMenu {
                        // Long press actions
                        TaskListLongPressActionsView(task: presenter.tasksList[i]) {
                            presenter.removeTask(task: presenter.tasksList[i])
                        }
                    }
                }
                // End For Each
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            } // End List
            .listStyle(.plain)
            .searchable(text: $presenter.searchText)
            
            if presenter.isLoading {
                ProgressView()
                    .scaleEffect(2)
            }
            // Panel with buttons for Task creation
            BottomPanelTaskCreationView(taskCountString: presenter.getTaskCountString())
        } // End ZStack
        .navigationTitle("Задачи")
        .toolbar {
            // Trailing button for turn on/off dark/light scheme
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isDarkEnabled.toggle()
                } label: {
                    Image(systemName: isDarkEnabled ? "moon.circle.fill" : "moon.circle") // Use a system icon
                }
            }
        }

        .onAppear {
            // Try Load from CoreData, if empty load from web
            presenter.tryLoadTasks()
            
            // Turn ON this and Turn OFF .tryLoadTasks to Fully Empty CoreData
//            presenter.removeAllTasks()

        }
    } // End Body
}

#Preview {
    TaskListScreenView(isDarkEnabled: .constant(false))
}
