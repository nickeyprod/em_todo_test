//
//  CircleCheckmarkView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct CircleCheckmarkView: View {
    let completed: Bool
    
    var body: some View {
        Image(systemName: completed ? "checkmark.circle" : "circle")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(completed ? Color.yellow : Color("checkmarkNotDone"))
    }
}

#Preview {
    CircleCheckmarkView(completed: true)
}
