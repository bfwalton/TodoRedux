//
//  File.swift
//  AppState
//
//  Created by Brandon Walton on 11/26/24.
//

import Foundation
import SwiftData

class TodoService {
    
    let database = Database()
    
    func getTodos() -> [Todo] {
        database.all().map { .init(id: $0.uuid, text: $0.text, timestamp: $0.timestamp) }
    }
    
    func addTodo(text: String) -> Todo {
        let item = database.add(text: text)
        return Todo(id: item.uuid, text: item.text, timestamp: item.timestamp)
    }
    
    func updateTodo(withID id: UUID, text: String) {
        guard let item = database.get(byID: id) else { return }
        item.text = text
        database.save()
    }
    
    func delete(withID id: UUID) {
        database.delete(byID: id)
    }
}

class Database {
    
    static let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var modelContext = ModelContext(sharedModelContainer)

    @Model
    class Item {
        
        var uuid: UUID = UUID()
        
        var text: String = ""
        
        var timestamp: Date = Date.now
        
        init() {
            
        }
    }
    
    func get(byID id: UUID) -> Item? {
        fetch(#Predicate {
            $0.uuid == id
        }).first
    }
    
    func all() -> [Item] {
        fetch()
    }
    
    func delete(byID id: UUID) {
        guard let item = get(byID: id) else { return }
        modelContext.delete(item)
        try! modelContext.save()
    }
    
    func add(text: String) -> Item {
        let item = Item()
        item.text = text
        modelContext.insert(item)
        try! modelContext.save()
        return item
    }
    
    func fetch(_ predicate: Predicate<Item>? = nil) -> [Item] {
        return try! modelContext.fetch(.init(predicate: predicate))
    }
    
    func save() {
        try! modelContext.save()
    }
}
