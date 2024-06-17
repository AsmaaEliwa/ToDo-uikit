//
//  ToDoListViewControllerTableViewController.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 06/06/2024.
//

import UIKit

class ToDoListViewControllerTableViewController: UITableViewController {
    var items:[Item] = []
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items")
    let userDefault = UserDefaults.standard
    var textFeild:UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let itemsArray = userDefault.object(forKey: "itemsArray") as? [Item]{
//            items = itemsArray
//        }
       
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
                let newItem = Item(name:text , status:false)
                    self.items.append(newItem)
                    print("added")
                //                self.userDefault.set(self.items, forKey: "itemsArray") // this will make the app crach because we are trying to save item model so we gonna use the plist 
                self.save()
                
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

        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if items[indexPath.row].status == false{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            items[indexPath.row].status = true
           
        }else{
            items[indexPath.row].status = false
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    func save(){
        let encoder = PropertyListEncoder()
         do{
             let data = try encoder.encode(items)
             try data.write(to: filePath!)
         }catch{
             print(error)
         }
             self.tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
