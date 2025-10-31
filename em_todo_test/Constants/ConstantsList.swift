//
//  ConstantsList.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

import SwiftUICore

// MARK: Все постоянные глобальные переменные отображены ниже

let DUMMY_TASKS_URL = "https://dummyjson.com/todos"

// MARK: - TaskView

struct taskHeadTitleFont {
    static let name = "SF Pro"
    static let weight = Font.Weight.bold
    static let weightNum = 700
    static let size = 34.0
    static let letterSpacing = 0.4
}

struct taskHeadTitleDateFont {
    static let name = "SF Pro"
    static let weight = Font.Weight.regular
    static let weightNum = 400
    static let size = 12.0
    static let letterSpacing = 0.0
    static let color = Color("taskHeadTitleDateFont")
}

struct taskTextFont {
    static let name = "SF Pro"
    static let weight = Font.Weight.regular
    static let weightNum = 400
    static let size = 16.0
    static let letterSpacing = -0.43
    static let color = Color("taskHeadTitleDateFont")
}

// MARK: - TaskListView

struct taskListItemHeadFont {
    static let name = "SF Pro"
    static let weight = Font.Weight.medium
    static let weightNum = 510
    static let size = 16.0
    static let letterSpacing = -0.43
    static let colorDone = Color("taskListItemHeadDoneFont")
    static let color = Color("taskListItemHeadFont")
    
}

struct taskListItemTextFont {
    static let name = "SF Pro"
    static let weight = Font.Weight.regular
    static let weightNum = 400
    static let size = 12.0
    static let letterSpacing = 0.0
    static let colorDone = Color("taskListItemHeadDoneFont")
    static let color = Color("taskListItemHeadFont")
}
