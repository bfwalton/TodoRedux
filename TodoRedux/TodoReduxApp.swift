//
//  TodoReduxApp.swift
//  TodoRedux
//
//  Created by Brandon Walton on 11/26/24.
//

import SwiftUI
import AppState
import SwiftData

@main
struct TodoReduxApp: App {
    
    @State var store = AppStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.store, store)
        }
    }
}
