//
//  ContentView.swift
//  TodoListTutorial
//
//  Created by Sanjith Udupa on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = "";
    @State var todos: [String] = [];
    
    var body: some View {
        VStack{
            Text("Todo List App!")
                .font(.title)
                .padding()
            
            HStack {
                TextField("Add a todo!", text: self.$text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    self.todos.append(self.text);
                    self.text = "";
                }) {
                    Text("Add!")
                        .padding(5)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(color: Color.black.opacity(0.25), radius: 6)
                        .foregroundColor(.white)
                }
            }.padding()
            
            List{
                ForEach(self.todos, id: \.self) { todo in
                    TodoItem(todo: todo)
                        .onLongPressGesture {
                            if let index = todos.firstIndex(of: todo) {
                                todos.remove(at: index)
                            }
                        }
                }
            }.animation(.spring())
        }
    }
}

struct CheckBox: View {
    @Binding var checked: Bool
    var body: some View {
        Button(action: {
            self.checked.toggle()
        }) {
            Image(systemName: self.checked ? "checkmark.circle" : "circle")
                .resizable()
                .foregroundColor(.green)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct TodoItem: View {
    @State var todo: String
    @State var checked = false;
    var body: some View {
        HStack {
            CheckBox(checked: $checked)
                .frame(width: 25, height: 25)
            Text(self.todo)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
