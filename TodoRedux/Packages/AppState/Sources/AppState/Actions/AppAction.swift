//
//  File.swift
//  AppState
//
//  Created by Brandon Walton on 11/26/24.
//

import Foundation

public enum AppAction: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .fetch: "Fetch"
        case .addTodo: "Add Todo"
        case .updateTodo: "Update Todo"
        case .deleteTodo: "Delete"
        }
    }
    
    case fetch
    case addTodo(text: String)
    case updateTodo(id: UUID, text: String)
    case deleteTodo(id: UUID)
}
