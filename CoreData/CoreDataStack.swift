//
//  CoreDataStack.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "TaskModel")
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
    
    func createTask(todo: String, userId: Double) {
        
        persistentContainer.performBackgroundTask { context in
            let newTask = ToDoTask(context: context)
            newTask.todo = todo
            newTask.userId = userId
            newTask.dateCreated = Date()

            do {
                try context.save()
                print("Saved new Task")
            } catch {
                print("Background save error:", error)
            }
        }
    }
    
    func getAllTasks(completion: ((_ error: String?, _ tasksList: [ToDoTask]?) -> Void)) {
        
        // Create a fetch request.
        let request = ToDoTask.fetchRequest()

        // Sort the fetched results, such as ascending by name.
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ToDoTask.id, ascending: true)]
        
        do {
            // Attempt to get all tasks.
            let tasksList = try persistentContainer.viewContext.fetch(request)

//            DispatchQueue.main.async {
//                completion(nil, tasksList)
//            }
            
        } catch {
            // Handle the error appropriately.
            print("Failed to get tasks list:", error.localizedDescription)
//            DispatchQueue.main.async {
//                completion(error.localizedDescription, nil)
//            }
        }
    }
    
    func delete(item: ToDoTask) {
        persistentContainer.performBackgroundTask { [weak self] context in
            context.delete(item)
            self?.save()
        }
        
    }
}
