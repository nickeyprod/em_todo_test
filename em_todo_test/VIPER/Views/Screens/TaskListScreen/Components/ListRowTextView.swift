//
//  ListRowTextView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct ListRowTextView: View {
    
    let taskText: String
    let completed: Bool
    
    var body: some View {
        Text(taskText)
            .font(.custom(taskListItemTextFont.name, size: taskListItemTextFont.size))
            .fontWeight(taskListItemTextFont.weight)
            .kerning(taskListItemTextFont.letterSpacing)
            .foregroundStyle(completed ? taskListItemTextFont.colorDone :  taskListItemTextFont.color)
            .padding(.bottom, 6)
            .padding(.top, 6)
    }
}

#Preview {
    ListRowTextView(taskText: "Sample", completed: false)
}
