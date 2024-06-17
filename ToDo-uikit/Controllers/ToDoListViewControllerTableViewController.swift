//
//  ToDoListViewControllerTableViewController.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 06/06/2024.
//

import UIKit
import Combine
import CoreData
class ToDoListViewControllerTableViewController: UITableViewController ,UISearchBarDelegate {
    var cancellables = Set<AnyCancellable>()
      let dataManager = DataManager.shared
     var items:[Item] = []
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   
    let userDefault = UserDefaults.standard
    var textFeild:UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let itemsArray = userDefault.object(forKey: "itemsArray") as? [Item]{
//            items = itemsArray
//        }
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        DataManager.shared.$items
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] updatedItems in
                        self?.items = updatedItems
                        self?.tableView.reloadData()
                    }
                    .store(in: &cancellables)
                
                // Initial fetch
                
        items = dataManager.items
//       loadItemsFromPList()
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return items.count
    }

    @IBAction func addMoreItemButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add more To Do", message: "What else should we add to do :) ", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: {action in
            if let text = self.textFeild?.text{
//                let newItem = Item(name:text , status:false)
                self.dataManager.addItem(title:text)
                self.tableView.reloadData()
//                    self.items.append(newItem)
//                    print("added")
                //                self.userDefault.set(self.items, forKey: "itemsArray") // this will make the app crach because we are trying to save item model so we gonna use the plist
//                self.save()
                
            }
            
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter New Item"
            self.textFeild = alertTextField
        }
        present(alert, animated: true ,completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.accessoryType = items[indexPath.row].status ? .checkmark : .none
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
           dataManager.updateItem(item: item)
           tableView.reloadRows(at: [indexPath], with: .automatic)
           tableView.deselectRow(at: indexPath, animated: true)

    }
//    func save(){
//        let encoder = PropertyListEncoder()
//         do{
//             let data = try encoder.encode(items)
//             try data.write(to: filePath!)
//         }catch{
//             print(error)
//         }
//             self.tableView.reloadData()
//    }
//    func loadItemsFromPList(){
//        let decoder = PropertyListDecoder()
//        if let data = try? Data(contentsOf: filePath!){
//            do{
//                let itemsArray = try decoder.decode([Item].self, from: data)
//                items = itemsArray
//            }catch{
//                print(error)
//            }
//        }
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = items[indexPath.row]
            dataManager.deleteItem(item: itemToDelete)
            
            // tableView will automatically update after fetchItems() updates items array
        } else if editingStyle == .insert {
            // Handle insertion if needed
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        items = items.filter{$0.title == searchBar.text}
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        if let searchText = searchBar.text{
            let predicate = NSPredicate(format: "title CONTAINS [cd] %@",searchText)
            request.predicate = predicate
            let sortDiscr = NSSortDescriptor(key: "title", ascending: true)
            request.sortDescriptors = [sortDiscr]
            do{
               let result =  try dataManager.persistentContainer.viewContext.fetch(request)
                items = result
                tableView.reloadData()
            }catch{
                print(error)
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            dataManager.fetchItems()
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
