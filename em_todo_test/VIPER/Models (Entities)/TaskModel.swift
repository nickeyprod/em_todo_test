//
//  TaskModel.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

import Foundation

// TaskModel used throughout whole App.
struct TaskModel: Codable, Equatable, Hashable {
    
    var id: Int = Int.random(in: 1...1000000000000000)
    var head: String?
    var todo: String?
    var completed: Bool
    var dateCreated: Date?
    var userId: Int
    
}

