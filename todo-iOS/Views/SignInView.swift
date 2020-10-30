//
//  SignInView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/10/29.
//

import SwiftUI

struct SignInView: View {

    @EnvironmentObject var authService: AuthenticationService

    var body: some View {
        Text("Todo")
            .font(.system(size: 20, weight: .heavy))

        VStack(spacing: 24) {

            Button(action: {
                authService.signin()
            }, label: {
                Text("Login")
                    .fontWeight(.medium)
                    .frame(minWidth: 160)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            })
        }
    }
}
