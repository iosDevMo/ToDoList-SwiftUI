//
//  ListViewModel.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI
import CoreData

@Observable class ListViewModel {
    
    let manager = DataManager.instance
    var items : [ItemEntity] = []
    
    init(){
        getItem()
    }
    
    func getItem(){
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let sort = NSSortDescriptor(keyPath: \ItemEntity.title, ascending: true)
        request.sortDescriptors = [sort]
        do{
            items = try manager.context.fetch(request)
        }catch let error{
            print("error fetching \(error.localizedDescription)")
        }
        
    }
    
    func addItem(title: String){
        let newItem = ItemEntity(context: manager.context)
        newItem.title = title
        save()
    }
    
    func updateDone(item: ItemEntity,done: Bool){
        let doneItem = item
        doneItem.done = done
        save()
    }
    
    func deleteItem(offsets: IndexSet){
        let index = offsets[offsets.startIndex]
        let deletedItem = items[index]
        manager.context.delete(deletedItem)
        save()
    }
    
    func save(){
        items.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.manager.save()
            self.getItem()
        }
        
    }
}
