//
//  TodoRepositoryProtocol.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 20.09.2022.
//

import Foundation

protocol TodoRepositoryProtocol {
    func getTodos() async throws -> [Todo]
    func deleteTodo(id: Int) async throws -> Todo
}
