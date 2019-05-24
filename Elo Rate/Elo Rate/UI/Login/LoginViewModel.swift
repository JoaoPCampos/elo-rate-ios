//
//  LoginViewModel.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

final class LoginViewModel {

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
private extension LoginViewModel {

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
extension LoginViewModel {

    func didUpdate(_ field: BaseTextField) {

        self.validate(field)
    }

    func shouldEnableLoginButton() -> Bool {

        let usernameFieldType: BaseTextField.FieldType = .username
        let passwordFieldType: BaseTextField.FieldType = .password

        return usernameFieldType.regex.matches(self.username) && passwordFieldType.regex.matches(self.password)
    }

    func login() {

        // TODO
    }
}
