//
//  Mock.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import Foundation

enum Mock {
    static let tasks: [Task] = [.init(id: "1", name: "夜ご飯作る", isDone: false),
                                .init(id: "2", name: "洗濯する", isDone: false),
                                .init(id: "3", name: "走る", isDone: true),
                                .init(id: "4", name: "kaimonosuru", isDone: true)]
}
