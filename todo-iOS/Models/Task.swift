//
//  Task.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let isDone: Bool
}
