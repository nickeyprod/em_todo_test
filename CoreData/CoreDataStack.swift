//
//  CoreDataStack.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import Foundation
import CoreData
import SwiftUI


// Initialization of CoreData, taken from official Apple documentation website.
class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "TaskModel")
//        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
//        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
}

extension CoreDataStack {
    // Add a convenience method to commit changes to the store.
    func save() {
        // Verify that the context has uncommitted changes.
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            // Attempt to save changes.
            try persistentContainer.viewContext.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    // Get all tasks from CoreData and pass them, or error to callback function.
    func getAllTasks(completion: ((_ error: String?, _ tasksList: [ToDoTask]?) -> Void)) {

        // Create a fetch request.
        let request = ToDoTask.fetchRequest()

        // Sort the fetched results, such as ascending by id.
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ToDoTask.id, ascending: true)]
        
        do {
            // Attempt to get all tasks.
            let tasksList = try persistentContainer.viewContext.fetch(request)
            completion(nil, tasksList)
        } catch {
            // Handle the error appropriately.
            print("Failed to get tasks list:", error.localizedDescription)
            completion(error.localizedDescription, nil)
        }
    }
    
    // Helping function, useful for debugging.
    func removeAllTasks() {
        
        // Create a fetch request.
        let request = ToDoTask.fetchRequest()

        do {
            // Attempt to get all tasks.
            let tasksList = try persistentContainer.viewContext.fetch(request)
            // Deleting one by one.
            for task in tasksList {
                persistentContainer.viewContext.delete(task)
            }
            self.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to delete", error.localizedDescription)
        }
    }
    
    // Delete specific task item.
    func delete(item: TaskModel, done: @escaping () -> Void) {
        // Create a fetch request.
        let request = ToDoTask.fetchRequest()
        
        // Get One Specific task.
        request.predicate = NSPredicate(format: "id = \(item.id)")
            
        do {
            // Try to delete.
            if let safeTask = try persistentContainer.viewContext.fetch(request).first {
                persistentContainer.viewContext.delete(safeTask)
                self.save()
                done()
            }
        } catch {
            print("Error during deleting Task")
        }
    }
    
    // Saving changes made in specific one task.
    func saveTask(task: TaskModel) {
        
        // Create a fetch request.
        let request = ToDoTask.fetchRequest()
        
        // Get one specific task predicate.
        request.predicate = NSPredicate(format: "id = \(task.id)")

        do {
            // Attempt to get specific task.
            let coreDataTask = try persistentContainer.viewContext.fetch(request)
            
            // If task is in CoreData, update it
            if let entityToUpdate = coreDataTask.first {
                entityToUpdate.id = Double(task.id)
                entityToUpdate.head = task.head
                entityToUpdate.todo = task.todo
                entityToUpdate.completed = task.completed
            } else {
                // IF task not found, create it from scratch
                let newTask = ToDoTask(context: persistentContainer.viewContext)
                newTask.head = task.head
                newTask.todo = task.todo
                newTask.userId = Double(task.userId)
                newTask.dateCreated = task.dateCreated
            }
            
            self.save()
        } catch {
            print("Saving error: ", error.localizedDescription)
        }
    }
}
