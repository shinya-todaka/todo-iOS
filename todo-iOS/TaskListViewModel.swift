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

    private var userId: String?
    private let tasksRepository = TasksRepository()

    private var cancellables: [AnyCancellable] = []

    @Published var tasks: [Task] = []

    func fetchTasks(userId: String) {
        tasksRepository.fetchTasks(userId: userId).sink { result in
            switch result {
            case let .failure(error):
                print(error)
            case .finished:
                print("finsihed")
            }
        } receiveValue: { tasks in
            self.tasks = tasks
        }.store(in: &cancellables)
    }

    func addTask(uid: String, task: Task, completion: @escaping (Error?) -> Void) {
        tasksRepository.addTask(uid: uid, task: task).sink { result in
            if case let .failure(error) = result {
                completion(error)
            }
        } receiveValue: { _ in completion(nil)
        }
        .store(in: &cancellables)
    }

    func updateTask(uid: String, task: Task) {
        guard let taskId = task.id else {
            return
        }

        tasksRepository
            .updateTask(uid: uid, taskId: taskId, task: task)
            .sink { error in
                print(error)
            } receiveValue: {
                print("success")
            }.store(in: &cancellables)
    }
}
