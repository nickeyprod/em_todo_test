//
//  TaskEditScreenView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

// MARK: Задача

import SwiftUI

struct TaskEditScreenView: View {

    var task: TaskModel?
    
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var presenter = TaskEditPresenter()

    var body: some View {
        ZStack {
            VStack() {
                
                // MARK: - Task Header
                VStack(alignment: .leading) {
                    // Task Head Input
                    TextField("Введите название", text: $presenter.taskHead)
                        .font(.custom(taskHeadTitleFont.name, size: taskHeadTitleFont.size))
                        .fontWeight(taskHeadTitleFont.weight)
                        .kerning(taskHeadTitleFont.letterSpacing)
                    // Task Data Text
                    TaskDateView(date: presenter.dateCreated.formatted())
                        
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                // MARK: - Task Description
                VStack {
                    ZStack(alignment: .topLeading) {
                        // Task Text Editor
                        TextEditor(text: $presenter.taskText)
                        
                        // If Task Text is Empty, show placeholder
                        if presenter.taskText.isEmpty {
                            Text(presenter.placeholder)
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
            if presenter.isLoading {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .onAppear {
            presenter.task = task
            presenter.isLoading = false
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(
                    action: {
                        // Save Task
                        presenter.saveCurrentTask()
                        // Go back
                        router.navigateBack()

                        
                    }) {
                        Image(systemName: "arrow.left")
                    })
    }
}

#Preview {
    TaskEditScreenView(task: TaskModel(id: 1, todo: "Sample", completed: false, userId: 123))
}
