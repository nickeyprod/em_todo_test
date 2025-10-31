//
//  Network.swift
//  em_todo_test
//
//  Created by Николай Ногин on 30.10.2025.
//

import Foundation

final class Network: ObservableObject {
    
    @Published var isLoading = false
    
    func getDataFromURL(completion: @escaping ((_ error: String?, _ data: TasksListJSON?) -> Void)) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let urlString = DUMMY_TASKS_URL
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return completion("Couldn't create url", nil)
        }
        
        // Create Request Object
        let request = URLRequest(url: url)
        
        // Task resume
        URLSession.shared.dataTask(with: request) {[weak self] (data, resp, err) in
            if let err = err {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    return completion(err.localizedDescription, nil)
                }
            } else {
                if let data = data {
                    if let returnedObj = try? JSONDecoder().decode(TasksListJSON.self, from: data) {
                        
                        return DispatchQueue.main.async {
                            self?.isLoading = false
                            completion(nil, returnedObj)
                        }
                    } else {
                        
                        return DispatchQueue.main.async {
                            self?.isLoading = false
                            completion("Object is absent", nil)
                        }
                    }
                }
            }
        }.resume()
    }
}


