//
//  TodoDetailView.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 15.11.2022.
//

import SwiftUI
import RealmSwift

struct TodoDetailView: View {

    @ObservedRealmObject var todo: Todo

    var body: some View {
        VStack {
            Text(todo.title)
            Toggle("Hotovo", isOn: $todo.isCompleted)
        }
        .padding()
    }
}
