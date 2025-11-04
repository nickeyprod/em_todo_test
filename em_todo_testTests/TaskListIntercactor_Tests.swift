//
//  TaskListIntercactorTests.swift
//  em_todo_testTests
//
//  Created by Николай Ногин on 03.11.2025.
//

import XCTest
@testable import em_todo_test

final class TaskListIntercactorTests: XCTestCase {
    
    var listInteractor: TaskListInteractor!
    var listPresenter: TaskListPresenter!
    var coreData: CoreDataStack!

    override func setUpWithError() throws {
        self.listInteractor = TaskListInteractor()
        self.listPresenter = TaskListPresenter()
        self.listInteractor.presenter = listPresenter
        self.coreData = CoreDataStack.shared
        
        let todo1 = ToDoTask(context: coreData.persistentContainer.viewContext)
        todo1.completed = true
        todo1.head = ""
        todo1.todo = "Yes No"
    
        self.listInteractor.tasksList = [
            todo1
        ]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.listInteractor = nil
        self.listPresenter = nil
    }
    
    // Should correctly load tasks from CoreData
    func test_correctLoadingTasksFromCoreData() {
        self.listInteractor.loadTasksFromCoreData()
        XCTAssertNotNil(self.listInteractor.tasksList[0], "TasksList of Interactor should be not nil")
    }
    
    // Should Correctly convert from ToDoTask to TaskModel
    func test_convertingFromCoreDataToTaskModelCorrect() throws {
        self.listInteractor.convertCoreDataTasksToTaskModels()
        XCTAssert(type(of:self.listInteractor.presenter!.tasksList[0]) == TaskModel.self)
    }
    
    // Should correctly load tasks from WEB
    func test_loadingTasksFromURL() async throws {
        var exp = expectation(description: "tasks should be loaded")
        self.listInteractor.presenter?.tasksList = []
        self.listInteractor.getTasksFromURL()
        sleep(1)
        exp.fulfill()
        XCTAssertFalse(self.listInteractor.tasksList.isEmpty)
        
        await fulfillment(of: [exp], timeout: 2.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
  

}
