//
//  AuthenticationService.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import Combine
import FirebaseAuth

class AuthenticationService: ObservableObject {

    @Published var authState: AuthState = .pending

    enum AuthState {
        case authenticated(FirebaseAuth.User)
        case notAuthenticated
        case pending
    }

    init() {
        Auth.auth().addStateDidChangeListener { authResult, user in
            if let user = authResult.currentUser {
                self.authState = .authenticated(user)
                return
            }
            self.authState = .notAuthenticated
        }
    }

    func signin() {
        Auth.auth().signInAnonymously { result, error in
            if let error = error {
                print(error)
                return
            }

            if let user = result?.user {
                print(user.uid)
            }
        }
    }
}
