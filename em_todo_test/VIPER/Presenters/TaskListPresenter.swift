//
//  TaskListPresenter.swift
//  em_todo_test
//
//  Created by Николай Ногин on 01.11.2025.
//

import Foundation
import SwiftUICore

// This Presenter of the TaskListScreenView, interacts with TaskListInteractor
final class TaskListPresenter: HeaderExtractor, ObservableObject {
    
    // Search text, entered in search bar
    @Published var searchText: String = "" {
        didSet {
            // Watch it changes, and filter results to display
            if searchText.isEmpty {
                filteredItems = tasksList
            } else {
                filteredItems = tasksList.filter {
                    $0.todo!.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
    // Initial tasks list, needed for resetting search.
    @Published var tasksList = [TaskModel]() {
        didSet {
            // If changed, update filtered items, to display updated list.
            filteredItems = tasksList
        }
    }
    
    // For displaying filtered results of the search.
    @Published var filteredItems = [TaskModel]()
    // Showing loader with the help of this variable.
    @Published var isLoading = true
    
    // This is once initialization of the Interactor.
    private var interactor = TaskListInteractor()
    
    // Override superclass init, it inherits some helper function.
    override init() {
        super.init()
        self.interactor.presenter = self
    }
    
    // Try to load tasks from CoreData, if empty, then load from the WEB.
    func tryLoadTasks() {
        self.interactor.loadTasksFromCoreData()
    }
    
    // This just a helpful function for debug, removes all tasks from CoreData.
    func removeAllTasks() {
        self.interactor.removeAllTasks()
    }
    
    // This checks task at Index (i) as completed/uncompleted and saves changes to CoreData.
    func checkAsDone(at i: Int) {
        self.tasksList[i].completed.toggle()
        self.interactor.save(task: self.tasksList[i])
    }
    
    // This only removes specific task, passed.
    func removeTask(task: TaskModel) {
        self.interactor.removeTask(task: task)
    }
    
    // Helping function to construct a header, when task don't have it.
    func header(of i: Int) -> String {
        // Check if item has header
        if let head = self.tasksList[i].head {
            return head
        }
        else {
            // If no header, take first two... words of task text...
            return self.getHeader(todoText: self.tasksList[i].todo ?? "")
        }
    }
    
    // This function trying to get right endings of word.
    func getTaskCountString() -> String {
        let lastDigit = String(self.tasksList.count).last
        if self.tasksList.count > 4 && self.tasksList.count < 21 {
            return "\(self.tasksList.count) задач"
        }
        if let safeLastDigit = lastDigit {
            if (safeLastDigit == "0" || safeLastDigit == "5" || safeLastDigit == "6" || safeLastDigit == "7" || safeLastDigit == "8" || safeLastDigit == "9") {
                return "\(self.tasksList.count) задач";
            }
            else if (safeLastDigit == "1") {
                return "\(self.tasksList.count) задача"
            }
            else if (safeLastDigit == "2" || safeLastDigit == "3" || safeLastDigit == "4") {
                return "\(self.tasksList.count) задачи"
            }
            else {
                return "\(self.tasksList.count) задач"
            }
        }
        return "\(self.tasksList.count) задач"
    }
    
}
