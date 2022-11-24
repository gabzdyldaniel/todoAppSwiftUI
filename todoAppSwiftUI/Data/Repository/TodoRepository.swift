//
//  TodoRepository.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 22.09.2022.
//

import Foundation

struct TodoRepository: TodoRepositoryProtocol {

    var dataSource: TodoDataSourceProtocol

    func getTodos() async throws -> [Todo] {
        return try await dataSource.getTodos()
    }

    func deleteTodo(id: Int) async throws -> Todo {
        return try await dataSource.deleteTodo(id: id)
    }
}
