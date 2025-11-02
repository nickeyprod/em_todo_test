//
//  TaskListInteractor.swift
//  em_todo_test
//
//  Created by Николай Ногин on 01.11.2025.
//

import Foundation

// This Interactor of the TaskListScreenView, interacts with CoreData and the WEB.
final class TaskListInteractor: ObservableObject {
    // CoreData initialization.
    private let coreData = CoreDataStack.shared
    // Network module initialization.
    private let network = Network()
    
    // Here saving CoreData Models.
    @Published var tasksList = [ToDoTask]()
    
    // Weak reference to prevent strong catch.
    weak var presenter: TaskListPresenter?
    
    // Getting tasks from URL https://dummyjson.com/todos, set to presenter and save to CoreData.
    func getTasksFromURL() {
        network.getDataFromURL { [weak self] error, data in
            if let error = error {
                print(error.description)
            }
            else {
                if let safeData = data {
                    self?.presenter?.tasksList = safeData.todos
                    self?.saveAllTasks()
                } else {
                    print("No raw data")
                }
            }
        }
    }
    
    // Save specific task to CoreData.
    func save(task: TaskModel) {
        coreData.saveTask(task: task)
    }
    
    // This just a helpful function for debug, removes all tasks from CoreData.
    func removeAllTasks() {
        self.coreData.removeAllTasks()
    }
    
    // This only removes specific task, passed. Then loading changes from CoreData.
    func removeTask(task: TaskModel) {
        self.coreData.delete(item: task) {
            // Load changes when deleted
            self.loadTasksFromCoreData()
        }
    }
    
    // Convert TaskModels of App to ToDoTask models of the CoreData, and save them all.
    func saveAllTasks() {
        guard self.presenter != nil else { return }
        coreData.persistentContainer.performBackgroundTask { context in
            for var task in self.presenter!.tasksList {
                let newTask = ToDoTask(context: context)
                let newID = Int.random(in: 1...1000000000000000)
                newTask.id = Double(newID)
                task.id = newID
                newTask.head = task.head
                newTask.todo = task.todo
                newTask.completed = task.completed
                newTask.userId = Double(task.userId)
            }
            do {
                try context.save()
            } catch {
                print("Background save error:", error)
            }
        }
    }
    
    // Load all tasks from CoreData, convert them back to TaskModel(s) and set them to tasksList.
    func loadTasksFromCoreData() {
        coreData.getAllTasks { error, tasksList in
            if let error = error {
                print("Error during loading tasks from CoreData: ", error.description)
            }
            
            if let safeTasksList = tasksList {
                // If no tasks at Core Data, then load them from the web
                if (safeTasksList.isEmpty) {
                    print("The CoreData is empty, loading from the web...")
                    self.getTasksFromURL()
                    DispatchQueue.main.async {self.presenter?.isLoading = false}
                }
                else {
                    print("CoreData has data! Loading from CoreData...")
                    // Set loaded tasks from CoreData to presenter
                    self.tasksList = safeTasksList
                    self.convertCoreDataTasksToTaskModels()
                    DispatchQueue.main.async { self.presenter?.isLoading = false }
                    
                }
            }
        }
    }
    
    // This function converts CoreData models to TaskModels used in the App.
    func convertCoreDataTasksToTaskModels() {
        var convertedTasksList = [TaskModel]()
        
        for task in self.tasksList {
            let newTask = TaskModel(id: Int(task.id), head: task.head, todo: task.todo, completed: task.completed, userId: Int(task.userId))
            convertedTasksList.append(newTask)
        }
        
        DispatchQueue.main.async {
            self.presenter?.tasksList = convertedTasksList
            self.presenter?.filteredItems = convertedTasksList
        }
    }
}
