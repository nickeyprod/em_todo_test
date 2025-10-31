//
//  TaskModel.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

struct TaskModel: Codable, Equatable, Hashable {
    
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
    
}

