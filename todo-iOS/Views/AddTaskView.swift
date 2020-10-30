//
//  AddTaskView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/30.
//

import SwiftUI

struct AddTaskView: View {

    @State var taskName = ""

    var addTask: (String) -> Void = { _ in }

    var body: some View {
        TextField("name", text: $taskName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(16)
        Button("create") {
            addTask(taskName)
        }
    }
}
