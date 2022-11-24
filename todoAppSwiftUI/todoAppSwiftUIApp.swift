//
//  todoAppSwiftUIApp.swift
//  todoAppSwiftUI
//
//  Created by Daniel Gabzdyl on 20.09.2022.
//

import SwiftUI
import BackgroundTasks
import RealmSwift
import Alamofire

@main
struct todoAppSwiftUIApp: SwiftUI.App {

    @Environment(\.scenePhase) private var phase

    @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            // NOTE: has to be wrapped in AnyView due to SwiftUI bug
            AnyView(
                TodosListView()
                    .environmentObject(networkMonitor)
            )
        }
        .backgroundTask(.appRefresh("fetchTodos")) {
            await getData()
        }
        .onChange(of: phase, perform: onPhaseChange(_:))
    }

    private func onPhaseChange(_ phase: ScenePhase) {
        switch phase {
        case .background:
            scheduleFetchTodosBackgroundTask()
        default:
            break
        }
    }

    func scheduleFetchTodosBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "fetchTodos")
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error.localizedDescription)
        }
    }

    @MainActor
    func getData() async {
        // schedule next background task
        scheduleFetchTodosBackgroundTask()

        let repository = TodoRepository(dataSource: TodoApiDataSource())

        do {
            let realm = try await Realm()
            try realm.write {
                realm.deleteAll()
            }
            for todo in try await repository.getTodos() {
                try! realm.write {
                    realm.add(todo)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
