//
//  em_todo_testApp.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

import SwiftUI

@main
struct em_todo_testApp: App {
    @StateObject private var router = NavigationRouter()
    @State private var isDarkEnabled = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.screens) {
                TaskListScreenView(isDarkEnabled: $isDarkEnabled)
                    .navigationDestination(for: Screen.self) { screen in
                        return screen
                            .preferredColorScheme(isDarkEnabled ? .dark : .light)
                            .environmentObject(router)

                    }
                    .preferredColorScheme(isDarkEnabled ? .dark : .light)
                    .environmentObject(router)

            }
            
        }
    }
}
