//
//  TodoAPIDataSource.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 20.09.2022.
//

import Foundation
import Alamofire

enum TodoApiError: Error {
    case error
}

final class TodoApiDataSource: TodoDataSourceProtocol {

    func getTodos() async throws -> [Todo] {
        guard let url = URL(string:  "https://utb-todo-backend.docker.b2a.cz/todo") else { throw TodoApiError.error }

        var todos: [Todo] = []
        do {
            todos = try await AF.request(url, method: .get).serializingDecodable([Todo].self).value
        } catch {
            print(error.localizedDescription)
        }

        return todos
    }

    func deleteTodo(id: Int) async throws -> Todo {
        guard let url = URL(string:  "https://utb-todo-backend.docker.b2a.cz/todo/\(id)") else { throw TodoApiError.error }

        var todo: Todo
        do {
            todo = try await AF.request(url, method: .delete).serializingDecodable(Todo.self).value
        } catch {
            throw TodoApiError.error
        }

        return todo
    }
}
