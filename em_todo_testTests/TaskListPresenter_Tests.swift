//
//  TaskListPresenter_Tests.swift
//  TaskListPresenter_Tests
//
//  Created by Николай Ногин on 30.10.2025.
//

import Testing
@testable import em_todo_test

struct TaskListPresenterTests {
    
    private var listPresenter = TaskListPresenter()
    
    init(listPresenter: TaskListPresenter = TaskListPresenter()) {
        self.listPresenter = listPresenter
        self.listPresenter.tasksList = [TaskModel(todo: "Go to walk", completed: false, userId: 1)]
    }

    @Test func initialLoadingShouldBeTrue() async throws {
        #expect(true == listPresenter.isLoading, "Initially Loading should be true")
    }
    
    // Should 
    @Test func checkTaskShouldChangeTaskCompletion() async throws {
        listPresenter.checkAsDone(at: 0)
        #expect(listPresenter.tasksList[0].completed == true, "Should change TaskModel completion")
    }
    
    @Test func checkHeaderExtractedWhenNoHeader() async throws {
        let head = listPresenter.getHeader(todoText: listPresenter.tasksList[0].todo ?? "")
        #expect(head.isEmpty == false, "Should extract TaskModel's Header when no header")
    }

}
