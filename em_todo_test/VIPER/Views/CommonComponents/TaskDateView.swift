//
//  TaskDateView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct TaskDateView: View {
    let date: String
    var body: some View {
        Text(date)
            .foregroundStyle(taskHeadTitleDateFont.color)
            .font(.custom(taskHeadTitleDateFont.name, size: taskHeadTitleDateFont.size))
            .fontWeight(taskHeadTitleDateFont.weight)
            .kerning(taskHeadTitleDateFont.letterSpacing)
    }
}

#Preview {
    TaskDateView(date: "02/10/24")
}
