//
//  AppStore.swift
//  AppState
//
//  Created by Brandon Walton on 11/26/24.
//

import Foundation
import SwiftUICore

public typealias AppStore = Store<AppState, AppAction, AppEnvironment>

public extension AppStore {
    
    convenience init() {
        self.init(
            initialState: .init(),
            reducer: appReducer,
            environment: .init()
        )
    }
}

public extension EnvironmentValues {
    
    @Entry var store: AppStore = AppStore(
        initialState: .init(),
        reducer: appReducer,
        environment: .init()
    )
}
