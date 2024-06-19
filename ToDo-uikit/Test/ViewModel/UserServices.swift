//
//  UserServices.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 18/06/2024.
//

import Foundation

enum FetchError: Error {
    case wrongData
}

class UserService {
    func fetchUsers(completion: @escaping (Result<[User], Error>)-> Void) {
        DispatchQueue.global().async {
            // Simulate network delay
            sleep(2)
//            let status = Bool.random()
            let status = true
            if status {
                let users = [
                    User(id: 1, name: "Alice", email: "alice@example.com"),
                    User(id: 2, name: "Bob", email: "bob@example.com"),
                    User(id: 3, name: "Charlie", email: "charlie@example.com")
                ]
                completion(.success(users))
                
            } else {
                completion(.failure(FetchError.wrongData))
                
            }
        }
    }
}
