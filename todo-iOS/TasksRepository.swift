//
//  TasksRepository.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/30.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class TasksRepository: ObservableObject {
    func fetchTasks(userId: String) -> AnyPublisher<[Task], Error> {
        let query = Firestore.firestore()
            .collection("users").document(userId)
            .collection("tasks").order(by: "createdAt")
        return query.addSnapshotListener().eraseToAnyPublisher()
    }

    func addTask(uid: String, task: Task) -> AnyPublisher<Void, Error> {
        let collectionReference = Firestore.firestore().collection("users").document(uid).collection("tasks")
        return collectionReference.addDocument(data: task)
    }

    func updateTask(uid: String, taskId: String, task: Task) -> AnyPublisher<Void, Error> {
        let documentReference = Firestore.firestore().collection("users").document(uid).collection("tasks").document(taskId)
        return documentReference.updateData(data: task)
    }

    func deleteTask(uid: String, taskId: String) -> AnyPublisher<Void, Error> {
        let documentReference = Firestore.firestore().collection("users").document(uid).collection("tasks").document(taskId)
        return documentReference.delete()
    }
}
