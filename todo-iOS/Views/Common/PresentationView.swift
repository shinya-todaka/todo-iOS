//
//  PresentationView.swift
//  todo-iOS
//
//  Created by 戸高新也 on 2020/11/03.
//

import SwiftUI

struct PresentationView: View, Identifiable {
    typealias ID = AnyHashable
    private let _id: ID
    var id: ID {
        _id
    }

    private let _body: AnyView
    var body: some View {
        _body
    }

    init?<V>(view: V?) where V: View & Identifiable {
        guard let view = view else {
            return nil
        }
        self._body = AnyView(view)
        self._id = view.id
    }
}
