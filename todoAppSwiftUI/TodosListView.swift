//
//  TodosListView.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 20.09.2022.
//

import SwiftUI
import RealmSwift

struct TodosListView: View {

    @ObservedObject var viewModel = ContentViewModel(repository: TodoRepository(dataSource: TodoApiDataSource()))
    @ObservedResults(Todo.self) var todos

    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    NavigationLink(value: todo) {
                        Text(todo.title)
                            .foregroundColor(todo.isCompleted ? .green : .black)
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                try? await viewModel.getTodos()
            }
            .navigationTitle("Count: \(todos.count)")
            .toolbarBackground(networkMonitor.isConnected ? .green : .pink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: Todo.self) { todo in
                TodoDetailView(todo: todo)
            }

        }
        .onAppear {
            networkMonitor.start()
        }
        .task {
            if todos.isEmpty {
                try? await viewModel.getTodos()
            }
        }
    }
}

struct TodosListView_Previews: PreviewProvider {
    static var previews: some View {
        TodosListView()
    }
}
