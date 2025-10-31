//
//  TasksListJSON.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

struct TasksListJSON: Codable {
    var todos: [TaskModel]
    var total: Int
    var skip: Int
    var limit: Int
}
