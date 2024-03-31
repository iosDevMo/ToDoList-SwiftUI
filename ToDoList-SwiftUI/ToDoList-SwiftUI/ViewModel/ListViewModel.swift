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
    var categories: [CategoryEntity] = []
    var items : [ItemEntity] = []
    var selectedCategory: CategoryEntity? {
        didSet{
            getItem()
        }
    }
    
    init(){
        
        getCategory()
    }
    
    func getCategory(){
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        let sort = NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        do{
            categories = try manager.context.fetch(request)
        }catch let error{
            print("error fetching \(error.localizedDescription)")
        }
    }
    
    func getItem(){
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let sort = NSSortDescriptor(keyPath: \ItemEntity.title, ascending: true)
        if let category = selectedCategory {
            let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", category.name ?? "")
            request.predicate = predicate
        }else{ return }
        request.sortDescriptors = [sort]
        do{
            items = try manager.context.fetch(request)
        }catch let error{
            print("error fetching \(error.localizedDescription)")
        }
        
    }
    
    func addCategory(name: String){
        let newCategory = CategoryEntity(context: manager.context)
        newCategory.name = name
        save()
    }
    
    func addItem(title: String){
        let newItem = ItemEntity(context: manager.context)
        newItem.title = title
        newItem.parentCategory = selectedCategory
        save()
    }
    
    func updateDone(item: ItemEntity,done: Bool){
        let doneItem = item
        doneItem.done = done
        save()
    }
    
    func deleteCategory(offsets: IndexSet){
        let index = offsets[offsets.startIndex]
        let deletedCategory = categories[index]
        manager.context.delete(deletedCategory)
        save()
    }
    
    func deleteItem(offsets: IndexSet){
        let index = offsets[offsets.startIndex]
        let deletedItem = items[index]
        manager.context.delete(deletedItem)
        save()
    }
    
    func save(){
        manager.save()
        categories.removeAll()
        items.removeAll()
        getCategory()
        getItem()
    }
}
