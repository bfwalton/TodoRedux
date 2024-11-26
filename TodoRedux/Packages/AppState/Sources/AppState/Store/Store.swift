//
//  File.swift
//  AppState
//
//  Created by Brandon Walton on 11/26/24.
//

import Foundation
import Combine
import Observation

@Observable
public final class Store<State, Action, Environment> {
    
    private var environment: Environment
    
    public private(set) var state: State
    
    private let reducer: Reducer<State, Action, Environment>
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        initialState: State,
        reducer: @escaping Reducer<State, Action, Environment>,
        environment: Environment
    ) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment
    }
    
    public func send(_ action: Action) {
        reducer(&state, action, environment)
    }
}


