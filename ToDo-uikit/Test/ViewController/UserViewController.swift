//
//  File.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 18/06/2024.
//

import Foundation
import UIKit
import Combine
//reload table after fetching and improve the last table view method
// 1 update the table any time the users changes by using combine
//2 using delegation
//3
class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Delegate {
 
    var delegate:Delegate?
    var tableView: UITableView!
    var viewModel = UserViewModel(userService: UserService())
    var cancellable = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        fetchData()
//        binding()   // 1 update the table any time the users changes by using combine
        setupObservers()
      
    }
    
    func didFinishFetch(users: [User]) {
        if !users.isEmpty {
            
//            tableView.reloadData()
        }
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .didFinishFetchUsers, object: nil)
           
        }
    @objc func reload(){
        
        tableView.reloadData()
    }
    
    func fetchData() {
        viewModel.fetchUsers()
    }
    func binding() {
        viewModel.$users
                .receive(on: DispatchQueue.main)
                .sink { [weak self] users in
                    print("Users updated: \(users)")  
                    self?.tableView.reloadData()
                    
                }
                .store(in: &cancellable)

    }
    func showError() {
        let alert = UIAlertController(title: "error", message: viewModel.serviceError?.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
}
