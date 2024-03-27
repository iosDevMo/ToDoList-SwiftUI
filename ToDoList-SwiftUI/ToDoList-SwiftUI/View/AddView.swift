//
//  AddView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var vm: ListViewModel
    @State var textField: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("type some thing here...", text: $textField)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.systemGray2).opacity(0.3))
                    .cornerRadius(10)
                Button {
                    if textField.count > 3 {
                        vm.addItem(title: textField)
                        textField = ""
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        alertTitle = "Your new ToDo Item must at least 3 characters🤓"
                        showAlert.toggle()
                    }
                    
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
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle))
        })
    }
}

#Preview {
    NavigationStack{
        AddView(vm: ListViewModel())
    }
    
}
