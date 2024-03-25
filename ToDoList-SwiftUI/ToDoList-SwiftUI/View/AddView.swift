//
//  AddView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI

struct AddView: View {
    @State var textField: String = ""
    var body: some View {
        ScrollView {
            VStack {
                TextField("type some thing here...", text: $textField)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.systemGray2).opacity(0.3))
                    .cornerRadius(10)
                Button {
                    //
                } label: {
                    Text("Save").textCase(.uppercase)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(.tintColor))
                        .cornerRadius(10)
                }

                
            }
            .padding()
        }
        .navigationTitle("Add an Item 🖋️")
    }
}

#Preview {
    NavigationStack{
        AddView()
    }
    
}
