//
//  ContentView.swift
//  TodoRedux
//
//  Created by Brandon Walton on 11/26/24.
//

import SwiftUI
import AppState

struct ContentView: View {
        
    @Environment(\.store) var store

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.state.todos) { todo in
                    TodoCell(todo: todo)
                }
                .onDelete(perform: delete)
            }
            .onAppear(perform: fetch)
            .toolbar {
                Button(action: addTodo, label: { Label("Add Todo", systemImage: "plus") })
            }
            .overlay {
                if store.state.isEmpty {
                    ContentUnavailableView("No Todos", systemImage: "carrot")
                }
            }
        }
    }
    
    private func fetch() {
        store.send(.fetch)
    }
    
    private func delete(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let id = store.state.todos[index].id
        store.send(.deleteTodo(id: id))
    }
    
    private func addTodo() {
        store.send(.addTodo(text: ""))
    }
}

extension ContentView {
    
    struct TodoCell: View {
        
        @Environment(\.store) var store
        
        let todo: Todo
        
        @State var todoText: String
        
        @FocusState var isFocused: Bool
        
        init(todo: Todo) {
            self.todo = todo
            self.todoText = todo.text
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                TextField("Todo", text: $todoText)
                    .focused($isFocused)
                    .font(.headline)
                    .onChange(of: isFocused, updateText)
                Text(todo.timestamp, format: .dateTime)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        
        private func updateText() {
            store.send(.updateTodo(id: todo.id, text: todoText))
        }
    }
}

#Preview {
    ContentView()
}
