//
//  ListRowView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 26/03/2024.
//

import SwiftUI

struct ListRowView: View {
    
    let title: String
    let done: Bool
    
    var body: some View {
        HStack {
            Image(systemName: done ? "checkmark.circle" : "circle")
                .foregroundColor(done ? .green : .red)
            Text(title)
            Spacer()
        }
        
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    ListRowView(title: "this is first title", done: false)
        .previewLayout(.sizeThatFits)
}
