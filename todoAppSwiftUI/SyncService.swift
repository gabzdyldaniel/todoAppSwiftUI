//
//  SyncService.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 15.11.2022.
//

import Foundation

/// Produce todos asynchronously.
///
/// > Warning: Todos are requested all the time.
/// > This service is for demonstration purposes only.
///
/// > Clarification: In real life it should make request once per X seconds
/// > and save it to the Realm with a well thought out functionality.
final class SyncService {
    public func sync() -> AsyncThrowingStream<[Todo], Error> {
        let repository = TodoRepository(dataSource: TodoApiDataSource())
        return AsyncThrowingStream { continuation in
            Task {
                while (true) {
                    do {
                        let todos = try await repository.getTodos()
                        continuation.yield(todos)
                    } catch {
                        continuation.finish(throwing: error)
                    }
                }
            }
        }
    }
}
