//
//  LoginView.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

final class LoginView: UIView {
    
    private enum Constants {
        
        static let usernamePlaceholder: String = "Username"
        static let passwordPlaceholder: String = "Password"
        static let loginButtonText: String = "Login"
        static let textColor: UIColor = .nero
        static let horizontalMargin: LayoutKitMargin = .offset(Branding.Spacing.S.float)
        static let margin: CGFloat = Branding.Spacing.M.float
        static let cornerRadius: CGFloat = Branding.Spacing.XXS.float
        static let insets = LayoutKitEdge.all(Branding.Spacing.S.float)
        static let fontM = Branding.Font.stencil(.bpmono, .M).font
    }
    
    private(set) lazy var usernameTextField: BaseTextField = {

        return BaseTextField(baseTextFieldDelegate: self).unmask()
    }()

    private(set) lazy var passwordTextField: BaseTextField = {

        return BaseTextField(baseTextFieldDelegate: self).unmask()
    }()
    
    let loginButton = UIButton(type: .roundedRect).unmask()
    
    override init(frame: CGRect = .zero) {
        
        super.init(frame: frame)
        
        self.configureView()
        self.configureSubViews()
        self.defineConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension LoginView {
    
    func configureView() {
        
        self.unmask()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.passwordTextField.isSecure = true
        
        self.loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
        
        self.add(self.usernameTextField, self.passwordTextField, self.loginButton)
    }
    
    func configureSubViews() {
        
        self.usernameTextField.placeholder = Constants.usernamePlaceholder
        self.passwordTextField.placeholder = Constants.passwordPlaceholder
        
        self.usernameTextField.textColor = Constants.textColor
        self.passwordTextField.textColor = Constants.textColor

        self.usernameTextField.tintColor = Constants.textColor
        self.passwordTextField.tintColor = Constants.textColor

        self.usernameTextField.font = Constants.fontM
        self.passwordTextField.font = Constants.fontM

        self.loginButton.titleLabel?.font = Constants.fontM
        
        [self.usernameTextField, self.passwordTextField, self.loginButton].forEach {

            $0.backgroundColor = .brilliance
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.layer.shouldRasterize = true
            $0.layer.rasterizationScale = UIScreen.main.scale
        }
        
        self.loginButton.setTitle(Constants.loginButtonText, for: .normal)
        self.loginButton.setTitleColor(Constants.textColor, for: .normal)
        self.loginButton.setTitleColor(.brilliance, for: .normal)
        self.loginButton.setTitleColor(.goshawkGrey, for: .disabled)
        self.loginButton.backgroundColor = .nero
        self.loginButton.isEnabled = false
    }
    
    func defineConstraints() {
        
        self.usernameTextField.edge(onlyTo: [.top, .leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.passwordTextField.topAnchor.bind(to: self.usernameTextField.bottomAnchor).addSpace(Constants.horizontalMargin)
        self.passwordTextField.edge(onlyTo: [.leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.loginButton.topAnchor.bind(to: self.passwordTextField.bottomAnchor).addSpace(Constants.horizontalMargin)
        self.loginButton.edge(onlyTo: [.leading, .trailing, .bottom], to: self, insets: [.all(Constants.margin)])
    }
    
    @objc
    func didPressLoginButton() {
        
        // TODO
        print("call login service")
    }
}

extension LoginView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        // TODO - update if valid field
        
        guard let text = textField.text else { return }
    }
}

// MARK: - BaseTextFieldDelegate

extension LoginView: BaseTextFieldDelegate {

    func didUpdate(_ field: BaseTextField, with text: String) {

        let usernameState = self.usernameTextField.customState
        let passwordState = self.passwordTextField.customState

        if usernameState == .valid && passwordState == .valid {

            self.loginButton.isEnabled = true

        } else {

            self.loginButton.isEnabled = false
        }
    }
}
