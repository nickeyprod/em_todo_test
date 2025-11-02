//
//  BottomPanelTaskCreationView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct BottomPanelTaskCreationView: View {
    let taskCountString: String
    
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Spacer()
                Text(taskCountString)
                    .foregroundStyle(Color("BottomPanelItemCountText"))
                Spacer()
                Button {
                    router.go(to: .taskEditScreenView(task: nil))
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(Color.yellow)
                }
            }
            .padding()
            
        }
        
        .background(Color("ListItemBottomPanel"))
        .ignoresSafeArea()
        
    }
}

#Preview {
    BottomPanelTaskCreationView(taskCountString: "7 Задач")
}
