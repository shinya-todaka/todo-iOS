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

    @State private var isPresentedSheet = false

    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    List(tasksListViewModel.tasks) { task in
                        Text(task.name)
                            .font(.subheadline)
                            .fontWeight(.bold)
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
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16))
                        }
                    }
                }
                .navigationTitle("Tasks")
                .onAppear(perform: {
                    tasksListViewModel.fetchTasks(userId: authUser.uid)
                })
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isPresentedSheet) {
            AddTaskView()
        }
    }
}
