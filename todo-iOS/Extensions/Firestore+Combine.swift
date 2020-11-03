//
//  Firestore+Combine.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/30.
//

import Combine
import FirebaseFirestore

enum CombineFirestoreError: Error {
    case snapshotNil
}

extension CollectionReference {
    func addDocument<T: Encodable>(data: T) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            do {
                _ = try self?.addDocument(from: data, completion: { error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    promise(.success(()))
                })
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

extension DocumentReference {

    class Subscription<S: Subscriber>: Combine.Subscription where S.Input == DocumentSnapshot, S.Failure == Error {

        var listener: ListenerRegistration?

        init(subscriber: S, documentReference: DocumentReference) {
            listener = documentReference.addSnapshotListener({ documentSnapshot, error in
                if let error = error {
                    subscriber.receive(completion: .failure(error))
                }

                guard let documentSnapshot = documentSnapshot else {
                    subscriber.receive(completion: .failure(CombineFirestoreError.snapshotNil))
                    return
                }

                _ = subscriber.receive(documentSnapshot)
            })
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            listener?.remove()
        }

    }

    struct Publisher: Combine.Publisher {
        typealias Output = DocumentSnapshot
        typealias Failure = Error

        let documentReference: DocumentReference
        init(documentReference: DocumentReference) {
            self.documentReference = documentReference
        }

        func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, documentReference: documentReference)
            subscriber.receive(subscription: subscription)
        }
    }

    func updateData<T: Encodable>(data: T) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            do {
                let fields = try Firestore.Encoder().encode(data)
                self?.updateData(fields, completion: { error in
                    if let error = error {
                        promise(.failure(error))
                    }
                    promise(.success(()))
                })
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func delete() -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            self?.delete { error in
                if let error = error {
                    promise(.failure(error))
                }
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }

    func addSnapshotListener() -> AnyPublisher<DocumentSnapshot, Error> {
        let publisher = Publisher(documentReference: self)
        return publisher.eraseToAnyPublisher()
    }
}

extension Query {
    class Subscription<S: Subscriber, D: Decodable>: Combine.Subscription where S.Input == [D], S.Failure == Error {

        var listener: ListenerRegistration?

        init(subscriber: S, query: Query) {
            listener = query.addSnapshotListener({ documentSnapshot, error in
                if let error = error {
                    subscriber.receive(completion: .failure(error))
                }

                guard let documents = documentSnapshot?.documents else {
                    subscriber.receive(completion: .failure(CombineFirestoreError.snapshotNil))
                    return
                }

                _ = subscriber.receive(documents.compactMap({ try? $0.data(as: D.self) }))
            })
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            listener?.remove()
        }
    }

    struct Publisher<D: Decodable>: Combine.Publisher {
        typealias Output = [D]
        typealias Failure = Error

        let query: Query
        init(query: Query) {
            self.query = query
        }

        func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription<S, D>(subscriber: subscriber, query: query)
            subscriber.receive(subscription: subscription)
        }
    }

    func addSnapshotListener<D: Decodable>() -> AnyPublisher<[D], Error> {
        let publisher = Publisher<D>(query: self)
        return publisher.eraseToAnyPublisher()
    }
}
