//
//  DataManager.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI
import CoreData

class DataManager {
    
    static let instance = DataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loadin core data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
            print("saved successfully")
        }catch let error {
            print("error saving data \(error.localizedDescription)")
        }
    }
}
