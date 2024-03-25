//
//  ContentView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI

struct ListView: View {
    
    
    var body: some View {
        List {
            ListRowView(title: "this is first title")
            
        }
        .listStyle(.plain)
        .navigationTitle("ToDo List📝")
        .navigationBarItems(leading: EditButton(),
                            trailing: NavigationLink("Add", destination: {AddView()}))
    }
}

#Preview {
    NavigationStack{
        ListView()
    }
    
}
