//
//  Task.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var isDone: Bool
    @ServerTimestamp var createdAt: Timestamp?
}
