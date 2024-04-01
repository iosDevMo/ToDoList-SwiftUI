//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI

struct ListView: View {
    
    @Bindable var vm: ListViewModel
    var selectedCategory: CategoryEntity?
    
    var body: some View {
        ZStack{
            if vm.items.isEmpty{
                NoItemView(vm: vm)
                    .transition(AnyTransition(.opacity.animation(.easeIn)))
            }else{
                List {
                    ForEach(vm.items){ item in
                        ListRowView(title: item.title ?? "", done: item.done)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    item.done.toggle()
                                    vm.updateDone(item: item, done: item.done)
                                }
                            }
                    }
                    .onDelete(perform: vm.deleteItem)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("\(selectedCategory?.name ?? "") List📝")
        .navigationBarItems(trailing: NavigationLink("Add", destination: {AddView(vm: vm)}))
        .onAppear(perform: {
            vm.selectedCategory = selectedCategory
        })
    }
}

#Preview {
    NavigationStack{
        ListView(vm: ListViewModel())
    }
}
