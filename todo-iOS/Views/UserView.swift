//
//  UserView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/31.
//

import SwiftUI

struct UserView: View, Identifiable {
    let userId: String

    @EnvironmentObject var authService: AuthenticationService

    var id: UUID {
        UUID()
    }

    var body: some View {
        Button(action: {
            authService.signout()
        }, label: {
            Text("signout")
                .fontWeight(.medium)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.accentColor)
                .cornerRadius(8)
        })
        .padding(32)
    }
}
