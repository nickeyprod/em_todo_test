//
//  Network.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

import Foundation

// Custom network module for working with the World Wide Web.
final class Network: ObservableObject {
    
    func getDataFromURL(completion: @escaping ((_ error: String?, _ data: TasksListJSON?) -> Void)) {
   
        let urlString = DUMMY_TASKS_URL
        
        guard let url = URL(string: urlString) else {
            return DispatchQueue.main.async {completion("Couldn't create url", nil)}
            
        }
        
        // Create Request Object
        let request = URLRequest(url: url)
        
        // Task resume
        URLSession.shared.dataTask(with: request) {(data, resp, err) in
            if let err = err {
                DispatchQueue.main.async {
                    return completion(err.localizedDescription, nil)
                }
            } else {
                if let data = data {
                    if let returnedObj = try? JSONDecoder().decode(TasksListJSON.self, from: data) {
                        
                        return DispatchQueue.main.async {
                            completion(nil, returnedObj)
                        }
                    } else {
                        
                        return DispatchQueue.main.async {
                            completion("Object is absent", nil)
                        }
                    }
                }
            }
        }.resume()
    }
}


