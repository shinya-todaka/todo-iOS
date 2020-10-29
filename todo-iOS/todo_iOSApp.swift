//
//  todo_iOSApp.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import SwiftUI
import Firebase

// swiftlint:disable type_name
@main
struct todo_iOSApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(AuthenticationService())
        }
    }
}
