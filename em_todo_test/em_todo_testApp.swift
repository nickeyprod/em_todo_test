//
//  em_todo_testApp.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

import SwiftUI

@main
struct em_todo_testApp: App {
    // Create an observable instance of the Core Data stack.
    @StateObject private var coreDataStack = CoreDataStack.shared
    // Create an observable instance of the Router.
    @StateObject private var router = NavigationRouter()
    // Create an observable instance of the Network.
    @StateObject private var network = Network()
    
    
//    @StateObject private var interactor = Interactor()
//    @StateObject private var presenter = Presenter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.screens) {
                TaskListScreenView()
                    .navigationDestination(for: Screen.self) { screen in
                        return screen
                    }
                    .environment(\.colorScheme, .light)
                    .environmentObject(router)
                    .environmentObject(network)
                    .environment(\.managedObjectContext,
                                  coreDataStack.persistentContainer.viewContext)
                    
            }
            
        }
    }
}
