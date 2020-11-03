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

        VStack(alignment: .center) {
            Spacer()

            Button(action: {
                authService.signin()
            }, label: {
                Text("sign in with apple")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            })
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 8, trailing: 32))

            Button(action: {
                authService.signin()
            }, label: {
                Text("signin")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            })
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 16, trailing: 32))
        }
    }
}
