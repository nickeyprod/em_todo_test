//
//  DividerView.swift
//  em_todo_test
//
//  Created by Николай Ногин on 31.10.2025.
//

import SwiftUI

struct DividerView: View {
    let isHidden: Bool
    var body: some View {
        Divider()
            .background(Color.gray)
            .opacity(isHidden ? 0.0 : 1.0)
            .padding(.horizontal, 20)
    }
}

#Preview {
    DividerView(isHidden: false)
}
