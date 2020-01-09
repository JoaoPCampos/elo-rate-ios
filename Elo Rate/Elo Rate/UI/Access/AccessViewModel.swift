//
//  AccessViewModel.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

final class AccessViewModel {

    enum LoginField {

        case username(String)
        case password(String)
    }

    private(set) var username: String
    private(set) var password: String

    init() {

        self.username = ""
        self.password = ""
    }

    func update(field: LoginField) {

        switch field {

        case .username(let username):
            self.username = username

        case .password(let password):
            self.password = password
        }
    }
}

// MARK: - Service
extension AccessViewModel {

    func login() {}
}
