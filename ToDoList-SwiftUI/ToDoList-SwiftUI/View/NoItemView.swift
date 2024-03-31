//
//  NoItemView.swift
//  ToDoList-SwiftUI
//
//  Created by mohamdan on 28/03/2024.
//

import SwiftUI

struct NoItemView: View {
    @Bindable var vm: ListViewModel
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("There are No Items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Click the Add button and add abunch of Items to your to do list.")
                    .padding(.bottom, 20)
                NavigationLink {
                    AddView(vm: vm)
                } label: {
                    Text("Add Something 🥳")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(animate ? .red : .blue))
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(color: Color(animate ? .red.opacity(0.7) : .blue.opacity(0.7)),
                        radius: animate ? 30 : /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                        x: 0, y: animate ? 50: 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        
    }
    func addAnimation() {
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
                Animation
                .easeInOut(duration: 2.0)
                .repeatForever()){
                    self.animate.toggle()
                }
        }
    }
}

#Preview {
    NavigationStack{
        NoItemView(vm: ListViewModel())
    }
}
