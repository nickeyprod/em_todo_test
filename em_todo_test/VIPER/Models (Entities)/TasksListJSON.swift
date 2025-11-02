//
//  TasksListJSON.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

// This helping model just for Decode data from the WEB.
struct TasksListJSON: Codable {
    var todos: [TaskModel]
    var total: Int
    var skip: Int
    var limit: Int
}
