//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI

struct ListView: View {
    
    @State private var vm: ListViewModel = ListViewModel()
    
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
        .navigationTitle("ToDo List📝")
        .navigationBarItems(leading: EditButton(),
                            trailing: NavigationLink("Add", destination: {AddView(vm: vm)}))
    }
}

#Preview {
    NavigationStack{
        ListView()
    }    
}
