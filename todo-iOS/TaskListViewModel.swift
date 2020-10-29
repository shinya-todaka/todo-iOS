//
//  TaskListViewModel.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import Firebase
import FirebaseFirestoreSwift
import Combine
import SwiftUI

class TaskListViewModel: ObservableObject {

    var listener: ListenerRegistration?
    var userId: String?

    @Published var tasks: [Task] = []

    func fetchTasks(userId: String) {
        print(userId)
        listener = Firestore.firestore().collection("users").document("shinya").collection("tasks").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error)
                return
            }

            guard let documents = snapshot?.documents else {
                return
            }

            let tasks = documents.compactMap { snapshot -> Task? in
                try? snapshot.data(as: Task.self)
            }

            self.tasks = tasks
        }
    }

    deinit {
        self.listener?.remove()
    }
}
