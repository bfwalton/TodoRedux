//
//  AppReducer.swift
//  AppState
//
//  Created by Brandon Walton on 11/26/24.
//

import Foundation
import Combine

public typealias Reducer<State, Action, Environment> = (inout State, Action, Environment) -> Void

public func appReducer(state: inout AppState, action: AppAction, environment: AppEnvironment) -> Void {
    print(action.description)
    switch action {
    case .fetch:
        state.todos.append(contentsOf: environment.todoService.getTodos())
    case .addTodo(let text):
        let todo = environment.todoService.addTodo(text: text)
        state.todos.append(todo)
    case .deleteTodo(let id):
        environment.todoService.delete(withID: id)
        state.todos.removeAll(where: { $0.id == id })
    case .updateTodo(id: let id, let text):
        guard let index = state.todos.firstIndex(where: { $0.id == id }) else { return }
        state.todos[index].text = text
        environment.todoService.updateTodo(withID: id, text: text)
    }
}
