//
//  DataManager.swift
//  ToDo-uikit
//
//  Created by asmaa gamal  on 17/06/2024.
//

import Foundation
import CoreData
class DataManager:ObservableObject{
    static let shared = DataManager()
    @Published var items: [Item] = []
    private init(){
        fetchItems()
    }
    lazy var persistentContainer: NSPersistentContainer = {
           
           // Pass the data model filename to the container’s initializer.
           let container = NSPersistentContainer(name: "DataModel")
           
           // Load any persistent stores, which creates a store if none exists.
           container.loadPersistentStores { _, error in
               if let error {
                   // Handle the error appropriately. However, it's useful to use
                   // `fatalError(_:file:line:)` during development.
                   fatalError("Failed to load persistent stores: \(error.localizedDescription)")
               }else{
                   print("load")
               }
           }
           return container
       }()
    
    
    func addItem(title:String){
        if let entity = NSEntityDescription.entity(forEntityName: "Item", in:persistentContainer.viewContext ){
            var newItem = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            newItem.setValue(title, forKey: "title")
            do{
                try persistentContainer.viewContext.save()
                print("saved")
                fetchItems()
            }catch{
                print(error)
            }
        }
    }
    
    func fetchItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            let data = try persistentContainer.viewContext.fetch(request)
            self.items = data
        }catch{
            print(error)
        }
    }
}
