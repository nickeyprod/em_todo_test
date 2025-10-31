//
//  ToDoTask+CoreDataProperties.swift
//  em_todo_test
//
//  Created by Николай Ногин on 01.11.2025.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var dateCreated: Date?
    @NSManaged public var id: Double
    @NSManaged public var todo: String?
    @NSManaged public var userId: Double

}

extension ToDoTask : Identifiable {

}
