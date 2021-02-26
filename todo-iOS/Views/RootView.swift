//
//  RootView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authenticationService: AuthenticationService

    var body: some View {
        switch authenticationService.authState {
        case .authenticated(let user):
            TaskListView(authUser: user)

        case .notAuthenticated:
            SignInView()

        case .pending:
            ProgressView()
        }
    }
}
