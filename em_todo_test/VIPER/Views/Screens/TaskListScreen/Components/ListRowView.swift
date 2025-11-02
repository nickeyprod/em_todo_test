//
//  ListRowView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct ListRowView: View {
    
    let headerText: String
    let taskText: String
    let date: String
    let isShowDivider: Bool
    let completed: Bool
    
    var body: some View {
        VStack {
            // Custom Divider
            DividerView(isHidden: isShowDivider)
            
            HStack(alignment: .top) {
                // Checkmark Icon
                CircleCheckmarkView(completed: completed)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Header of Row
                    ListRowHeaderView(headerText: headerText, completed:  completed)
                    
                    // Text of Task of Row
                    ListRowTextView(taskText: taskText, completed: completed)
                    
                    // Task Date Text
                    TaskDateView(date: date)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.00000001))
                .foregroundStyle(taskListItemHeadFont.color)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        
    }
}

#Preview {
    ListRowView(headerText: "Sample", taskText: "Sample text", date: "02/03/2024", isShowDivider: false, completed: false)
}
