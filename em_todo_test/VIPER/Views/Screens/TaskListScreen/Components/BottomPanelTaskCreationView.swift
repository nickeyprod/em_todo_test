//
//  BottomPanelTaskCreationView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct BottomPanelTaskCreationView: View {
    var body: some View {
        HStack {
            HStack {
                Spacer()
                Text("7 задач")
                    .foregroundStyle(Color("BottomPanelItemCountText"))
                Spacer()
                Button {
                    print("new task")
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(Color.yellow)
                }
            }.padding()
            
        }
        .ignoresSafeArea()
        .background(Color("ListItemBottomPanel"))
    }
}

#Preview {
    BottomPanelTaskCreationView()
}
