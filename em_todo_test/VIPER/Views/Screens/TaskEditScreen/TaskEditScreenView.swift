//
//  TaskEditScreenView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

// MARK: Задача

import SwiftUI

struct TaskEditScreenView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let task: TaskModel
    
    @State private var taskHead = ""
    @State private var taskText = ""
    @State private var placeholder = "Введите текст заметки"
    
    var body: some View {
        VStack() {
            // MARK: - Task Header
            VStack(alignment: .leading) {
                // Task Head Input
                TextField("Введите название", text: $taskHead)
                    .font(.custom(taskHeadTitleFont.name, size: taskHeadTitleFont.size))
                    .fontWeight(taskHeadTitleFont.weight)
                    .kerning(taskHeadTitleFont.letterSpacing)
                // Task Data Text
                TaskDateView(date: "02/10/24")
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            // MARK: - Task Description
            VStack {
                ZStack(alignment: .topLeading) {
                    // Task Text Editor
                    TextEditor(text: $taskText)
                    
                    // If Task Text is Empty, show placeholder
                    if taskText.isEmpty {
                        Text(placeholder)
                            .padding(.top, 9)
                            .padding(.leading, 4)
                            .allowsHitTesting(false)
                            .foregroundStyle(Color.secondary)
                    }
                }
                .font(.custom(taskTextFont.name, size: taskTextFont.size))
                .fontWeight(taskTextFont.weight)
                .kerning(taskTextFont.letterSpacing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TaskEditScreenView(task: TaskModel(id: 1, todo: "Sample", completed: false, userId: 123))
}
