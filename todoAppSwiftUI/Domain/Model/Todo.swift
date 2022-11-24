//
//  Todo.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 15.11.2022.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var isCompleted: Bool
}
