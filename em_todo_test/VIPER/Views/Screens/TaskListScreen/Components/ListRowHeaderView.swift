//
//  ListRowHeaderView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct ListRowHeaderView: View {
    
    let headerText: String
    let completed: Bool
    
    var body: some View {
        Text(headerText)
            .font(.custom(taskListItemHeadFont.name, size: taskListItemHeadFont.size))
            .fontWeight(taskListItemHeadFont.weight)
            .kerning(taskListItemHeadFont.letterSpacing)
            .foregroundStyle(completed ?  taskListItemHeadFont.colorDone : taskListItemHeadFont.color)
            .strikethrough(completed)    }
}

#Preview {
    ListRowHeaderView(headerText: "gogo", completed: false)
}
