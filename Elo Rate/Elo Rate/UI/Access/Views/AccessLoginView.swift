//
//  AccessLoginView.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import LayoutKit

protocol AccessLoginViewDelegate: class {

    func loginButtonPressed(username: String, password: String)
}

final class AccessLoginView: UIView {
    
    private enum Constants {

        static let login: String = "Login"

        /// .offset(S) - 12
        static let offset: LayoutKitMargin = .offset(Branding.Spacing.S.float)
        /// .M - 24
        static let margin: CGFloat = Branding.Spacing.M.float
    }
    
    private weak var delegate: AccessLoginViewDelegate?
    
    private lazy var usernameTextField: AccessTextField = { AccessTextField(.username, delegate: self).unmask() }()
    private lazy var passwordTextField: AccessTextField = { AccessTextField(.password, delegate: self).unmask() }()
    private lazy var loginButton: UIButton = { UIFactory.button(title: Constants.login) }()
    
    private var isLoginAllowed: Bool { self.usernameTextField.isValid() && self.passwordTextField.isValid() }

    init(frame: CGRect = .zero, delegate: AccessLoginViewDelegate) {

        self.delegate = delegate

        super.init(frame: frame)
        
        self.configureView()
        self.configureSubViews()
        self.defineConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Private
private extension AccessLoginView {
    
    func configureView() {
        
        self.add(self.usernameTextField, self.passwordTextField, self.loginButton)
    }
    
    func configureSubViews() {
        
        self.loginButton.isEnabled = false
        
        self.loginButton.addTarget(self, action: #selector(self.didPressLoginButton), for: .touchUpInside)
    }
    
    @objc
    func didPressLoginButton() {
        
        guard self.isLoginAllowed,
            let username = self.usernameTextField.text,
            let password = self.passwordTextField.text else { return }
        
        self.delegate?.loginButtonPressed(username: username, password: password)
    }
    
    func defineConstraints() {
        
        self.usernameTextField.edge(onlyTo: [.top, .leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.passwordTextField.topAnchor.bind(to: self.usernameTextField.bottomAnchor).addSpace(Constants.offset)
        self.passwordTextField.edge(onlyTo: [.leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.loginButton.topAnchor.bind(to: self.passwordTextField.bottomAnchor).addSpace(Constants.offset)
        self.loginButton.edge(onlyTo: [.leading, .trailing, .bottom], to: self, insets: [.all(Constants.margin)])
    }
}

extension AccessLoginView: AccessTextFieldDelegate {
    
    func textChanged() {
        
        self.loginButton.isEnabled = self.isLoginAllowed
    }
}
