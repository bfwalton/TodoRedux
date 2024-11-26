//
//  Todo.swift
//  AppState
//
//  Created by Brandon Walton on 11/26/24.
//

import Foundation

public struct Todo: Identifiable, Equatable {
    
    public var id = UUID()
    
    public var text: String
    
    public var timestamp: Date
}
