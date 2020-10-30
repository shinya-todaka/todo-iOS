//
//  TaskListView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import FirebaseAuth
import SwiftUI

struct TaskListView: View {

    @EnvironmentObject var authService: AuthenticationService
    @ObservedObject private var tasksListViewModel = TaskListViewModel()

    let authUser: FirebaseAuth.User

    @State private var isPresentedSheet = false

    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    List(tasksListViewModel.tasks) { task in
                        TaskView(task: task, updateTask: { task in
                            tasksListViewModel.updateTask(uid: authUser.uid, task: task)
                        })
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                isPresentedSheet.toggle()
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
                .navigationBarItems(trailing: Button("sign out", action: {
                    authService.signout()
                }))
                .onAppear(perform: {
                    tasksListViewModel.fetchTasks(userId: authUser.uid)
                })
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isPresentedSheet) {
            AddTaskView(addTask: { task in
                let task = Task(name: task, isDone: false)
                tasksListViewModel.addTask(uid: authUser.uid, task: task, completion: { error in
                    if let error = error {
                        print(error)
                        return
                    }
                    self.isPresentedSheet = false
                })
            })
        }
    }
}
