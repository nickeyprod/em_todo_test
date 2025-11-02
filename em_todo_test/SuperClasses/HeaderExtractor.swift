//
//  Extensions.swift
//  em_todo_test
//
//  Created by Николай Ногин on 02.11.2025.
//

import SwiftUI

// Helping function, two classes inheriting from it in the App.
class HeaderExtractor {
    // This function constructing a header, if no header in TaskModel.
    // If no header, extract header from task text for displaying
    func getHeader(todoText: String) -> String {
        let headerSplitted = todoText.split(separator: " ")
        var header = ""
        
        // Check for proposal in the middle, return 3 words.
        if (headerSplitted.count == 1) {
            header = String(headerSplitted[0])
            
        }
        else if (headerSplitted[1].count == 1 || headerSplitted[1].count == 2) {
            header = String(headerSplitted[0] + " " + headerSplitted[1] + " " + headerSplitted[2])
        }
        else {
            // if no proposal, return only 2 words
            header = String(headerSplitted[0] + " " + headerSplitted[1])
        }
        
        return header
    }
}
