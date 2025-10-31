//
//  TaskListScreenView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

// MARK: Список Задач

import SwiftUI

struct TaskListScreenView: View {
    
    @EnvironmentObject var network: Network
    
    @State private var searchText: String = ""
    @State var tasksList = [TaskModel]()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(tasksList.indices, id: \.self) { i in
                    // Row View
                    ListRowView(headerText: getHeader(todoText: tasksList[i].todo), taskText: tasksList[i].todo, date: "02/03/2024", isShowDivider: tasksList[i].id == 1, completed: tasksList[i].completed)
                    .onTapGesture {
                        // Check done
                        checkAsDone(at: i)
                    }
                    .contextMenu {
                        // Long press actions
                        TaskListLongPressActionsView(task: tasksList[i])
                    }
                } // End For Each
                .onDelete(perform: deleteTask)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            } // End List
            .listStyle(.plain)
            .searchable(text: $searchText)
        } // End ZStack
        .navigationTitle("Задачи")
        .onAppear {
            network.getDataFromURL { error, data in
                if (error != nil) {
                    print(error)
                } else {
                    tasksList = data?.todos ?? []
                }
            }
        }
        // Panel with buttons for Task creation
        BottomPanelTaskCreationView()
        
    } // End Body
    func checkAsDone(at i: Int) {
        tasksList[i].completed.toggle()
    }
    
    func deleteTask(at offsets: IndexSet) {
        print("remove")
    }
    
    // prepare header for display
    func getHeader(todoText: String) -> String {
        let headerSplitted = todoText.split(separator: " ")
        var header = ""
        
        // check for proposal in the middle, return 3 words
        if (headerSplitted.count == 1) {
            header = String(headerSplitted[0])
            
        }
        else if (headerSplitted[1].count == 1 || headerSplitted[1].count == 2) {
            header = String(headerSplitted[0] + " " + headerSplitted[1] + " " + headerSplitted[2])
        } else {
            // if no proposal, return only 2 words
            header = String(headerSplitted[0] + " " + headerSplitted[1])
        }
        
        return header
    }
}

#Preview {
    TaskListScreenView()
}
