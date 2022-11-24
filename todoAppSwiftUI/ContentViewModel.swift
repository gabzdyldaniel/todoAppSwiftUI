//
//  ContentViewModel.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 15.11.2022.
//

import Foundation
import RealmSwift

@MainActor
class ContentViewModel: ObservableObject {

    var repository: TodoRepositoryProtocol

    init(repository: TodoRepositoryProtocol) {
        self.repository = repository
    }

    func getTodos() async throws {
        do {
            let realm = try await Realm()
            try realm.write {
                realm.deleteAll()
            }
            for todo in try await repository.getTodos() {
                try realm.write {
                    realm.add(todo)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
