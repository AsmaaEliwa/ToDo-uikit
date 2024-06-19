//
//  CategeryViewController.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 17/06/2024.
//

import UIKit
import CoreData

class CategeryViewController: UITableViewController {
    var categries:[Categry] = []
    let context = DataManager.shared.persistentContainer.viewContext
    var textFiels:UITextField?
    
    @IBAction func addCategryButton(_ sender: Any) {
        let alert = UIAlertController(title: "New categry", message: "Add new categry", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: {action in
            let newCategry = Categry(context: self.context)
            newCategry.title = self.textFiels?.text
            self.save()
            self.loadCategries()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField{textField in
            textField.placeholder = "categry name"
            self.textFiels = textField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    func save(){
        do{
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    func loadCategries(){
        let request:NSFetchRequest<Categry> = Categry.fetchRequest()
        do{
            let data = try context.fetch(request)
            categries = data
            tableView.reloadData()
        }catch{
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategries()
  
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categeryCell", for: indexPath)
        cell.textLabel?.text = categries[indexPath.row].title
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination  as? ToDoListViewControllerTableViewController {
           if let indexPath = tableView.indexPathForSelectedRow?.row{
               destination.categry = categries[indexPath]
           }
       }
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
