//
//  CategoryView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 30/03/2024.
//

import SwiftUI

struct CategoryView: View {
    @State var vm: ListViewModel = ListViewModel()
    @State var textField: String = ""
    @State var showAlert: Bool = false
    @State var renameAlert: Bool = false
    
    var body: some View {
        ZStack{
            if vm.categories.isEmpty{
                VStack {
                    Text("Click the Add button and add abunch of Categories to your to do list.🖋️")
                        .font(.title)
                        .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                    .padding(.horizontal, 20)
                    Spacer()

                }
            }else{
                List{
                    ForEach(vm.categories){ category in
                        NavigationLink(category.name!) {
                            ListView(vm: vm, selectedCategory: category)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button("Rename") {
                                renameAlert.toggle()
                            }
                            .tint(.green)
                        }
                        .alert("Add new category name", isPresented: $renameAlert) {
                            TextField("Enter new category name", text: $textField)
                            Button("Save") {
                                if !textField.isEmpty{
                                    category.name = textField
                                    self.vm.save()
                                    textField = ""
                                }else{return}
                            }
                            Button("Cancle", role: .cancel, action: {textField = ""})
                        }
                        
                    }
                    .onDelete(perform: vm.deleteCategory)
                }
                .listStyle(.plain)
            }
                
            
        }
        .navigationTitle("Categories")
        .navigationBarItems(leading: EditButton(), trailing: Button("Add", action: {
            showAlert.toggle()
        }))
        .alert("Add new category", isPresented: $showAlert) {
            TextField("Enter new category", text: $textField)
            Button("Save") {
                if !textField.isEmpty{
                    self.vm.addCategory(name: textField)
                    textField = ""
                }else{return}
            }
            Button("Cancle", role: .cancel, action: {textField = ""})
        }
    }
}
    
    #Preview {
        NavigationStack{
            CategoryView()
        }
    }
