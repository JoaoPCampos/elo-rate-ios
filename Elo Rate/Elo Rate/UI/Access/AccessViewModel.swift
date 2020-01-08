//
//  AccessViewModel.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

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

// MARK: - Private
private extension AccessViewModel {

    func validate(_ field: BaseTextField) {

        guard let text = field.text else { return }

        let state = self.regex(validate: field)

        field.setState(state)

        switch field.type {

        case .username:
            self.username = text

        case .password:
            self.password = text
        }
    }

    func regex(validate field: BaseTextField) -> BaseTextField.CustomState {

        let match = field.type.regex.matches(field.text)

        return match ? .valid : .error
    }
}

// MARK: - Service
extension AccessViewModel {

    func didUpdate(_ field: BaseTextField) {

        self.validate(field)
    }

    func shouldEnableLoginButton() -> Bool {

        let usernameRegex = BaseTextField.FieldType.username.regex
        let passwordRegex = BaseTextField.FieldType.password.regex

        return usernameRegex.matches(self.username) && passwordRegex.matches(self.password)
    }

    func login() {

        ServiceManager.init(service: ServiceProtocol)
    }
}
