// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public struct AppState: Equatable {
    
    public var todos: [Todo]
    
    public var isEmpty: Bool { todos.isEmpty }
    
    init() {
        self.todos = []
    }
}
