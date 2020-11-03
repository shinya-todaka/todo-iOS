//
//  TaskListView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import FirebaseAuth
import SwiftUI

struct TaskListView: View {

    @ObservedObject private var tasksListViewModel = TaskListViewModel()

    let authUser: FirebaseAuth.User

    @State private var presentationView: PresentationView?

    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    List {
                        ForEach(tasksListViewModel.tasks, id: \.self) { task in
                            TaskView(task: task, updateTask: { task in
                                tasksListViewModel.updateTask(uid: authUser.uid, task: task)
                            })
                        }.onDelete(perform: { indexSet in
                            tasksListViewModel.deleteTask(uid: authUser.uid, indexSet: indexSet)
                        })
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                self.presentationView = PresentationView(view: AddTaskView(addTask: { taskName in
                                    tasksListViewModel.addTask(uid: authUser.uid, task: .init(name: taskName, isDone: false))
                                }))
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.black)
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16))
                        }
                    }
                }
                .navigationTitle("Tasks")
                .navigationBarItems(trailing:
                                        Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .onTapGesture(perform: {
                                            self.presentationView = PresentationView(view: UserView(userId: authUser.uid))
                                        })
                )
                .onAppear(perform: {
                    tasksListViewModel.fetchTasks(userId: authUser.uid)
                })
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .sheet(item: $presentationView, content: { $0 })
    }
}
