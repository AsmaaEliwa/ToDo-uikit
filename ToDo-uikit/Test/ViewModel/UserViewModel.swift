//
//  UserViewModel.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 18/06/2024.
//

import Foundation

extension Notification.Name{
    static let didFinishFetchUsers = Notification.Name("didFinishFetchUsers")
}

protocol Delegate{
    func didFinishFetch(users: [User])
}

class UserViewModel: ObservableObject {
   @Published var users: [User] = []
    var delegate:Delegate?
    var serviceError: Error?
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUsers(){
        userService.fetchUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users
                    self.delegate?.didFinishFetch(users: users)
                case .failure(let error):
                    self.serviceError = error
                }
            }
        }
    }
}
