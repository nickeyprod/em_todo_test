//
//  TaskEditInteractor.swift
//  em_todo_test
//
//  Created by Николай Ногин on 01.11.2025.
//

import Foundation
import SwiftUICore

// This Interactor of the TaskEditScreenView, interacts with CoreData.
final class TaskEditInteractor: ObservableObject {
    // CoreData initialization.
    private let coreData = CoreDataStack.shared
    
    // Weak reference to prevent strong catch. (Have not used yet.)
    weak var presenter: TaskEditPresenter?
    
    // Saving currently editing task, or create a new one, if needed.
    func save(task: TaskModel) {
        coreData.saveTask(task: task)
    }
    
}
