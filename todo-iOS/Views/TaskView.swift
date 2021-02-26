//
//  TaskView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/30.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    var updateTask: (Task) -> Void = { _ in }

    var body: some View {
        HStack {
            Text(task.name)
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()

            (task.isDone ?
                Image(systemName: "checkmark.circle.fill") : Image(systemName: "circle"))
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    var newTask = task
                    newTask.isDone.toggle()
                    updateTask(newTask)
                }
        }
    }
}
