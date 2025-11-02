//
//  TaskEditPresenter.swift
//  em_todo_test
//
//  Created by Николай Ногин on 01.11.2025.
//

import Foundation
import SwiftUI

// This Presenter of the TaskEditScreenView, interacts with TaskEditInteractor
final class TaskEditPresenter: HeaderExtractor, ObservableObject {
    
    // Editable attributes of Task (TaskModel).
    @Published var taskHead: String = ""
    @Published var taskText: String = ""
    @Published var dateCreated: Date = Date()
    // Custom placeholder for TextEditor.
    @Published var placeholder = "Введите текст заметки"
    
    // TaskModel passed to TaskEditScreenView, attached at .onAppear().
    @Published var task: TaskModel? {
        didSet {
            // When attached, auto-setting all inputs fields of the TaskEditScreenView.
            if let safeTask = task {
                // Title of task
                if let head = safeTask.head {
                    taskHead = head
                }
                // Text of task
                if let todo = safeTask.todo {
                    taskText = todo
                }
                // Date of task
                if let dateCreated = safeTask.dateCreated {
                    self.dateCreated = dateCreated
                }
            }
            
        }
    }
    
    // Showing loader with the help of this variable.
    @Published var isLoading = true
    
    // This is once initialization of the Interactor.
    private var interactor = TaskEditInteractor()
    
    // Override superclass init, it inherits some helper function.
    override init() {
        super.init()
        self.interactor.presenter = self
    }
    
    // Save currently editing task, or create a new one, if needed.
    func saveCurrentTask() {
        
        if var safeTask = task {
            // Set changes done by user to TaskModel before saving it to CoreData.
            safeTask.head = self.taskHead
            safeTask.todo = self.taskText
            safeTask.dateCreated = self.dateCreated
            self.interactor.save(task: safeTask)
        }
        else {
            // If nothing entered, do not save the Task.
            if (taskHead == "" && taskText == "") {
                return
            }
            // If task not passed, create new Task with entered by user data.
            let newTask = TaskModel(head: self.taskHead, todo: self.taskText, completed: false, dateCreated: self.dateCreated, userId: 1)
            self.interactor.save(task: newTask)
        }
    }
    
}
