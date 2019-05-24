//
//  LoginView.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

@objc
protocol LoginViewDelegate: BaseTextFieldDelegate {

    func loginButtonPressed()
}

final class LoginView: UIView {
    
    private enum Constants {

        enum animation {

            /// 0.5
            static let duration: TimeInterval = 0.5
            /// 0.3
            static let spring: CGFloat = 0.3
            /// 0.1
            static let speed: CGFloat = 0.1
        }

        enum button {

            /// Login
            static let text: String = "Login"
            /// .brilliance
            static let color: UIColor = .brilliance
            /// .goshawkGrey
            static let disabledColor: UIColor = .goshawkGrey
            /// .nero
            static let backgroundColor: UIColor = .nero
            /// .bpmono .M
            static let font = Branding.Font.stencil(.bpmono, .M).font
        }

        /// .offset(S) - 12
        static let horizontalMargin: LayoutKitMargin = .offset(Branding.Spacing.S.float)
        /// .M - 24
        static let margin: CGFloat = Branding.Spacing.M.float
        /// .XXS - 4
        static let cornerRadius: CGFloat = Branding.Spacing.XXS.float
        /// .all(S) - 12
        static let insets = LayoutKitEdge.all(Branding.Spacing.S.float)
    }
    
    private lazy var usernameTextField: BaseTextField = {

        return BaseTextField(delegate: self.delegate, type: .username).unmask()
    }()

    private lazy var passwordTextField: BaseTextField = {

        return BaseTextField(delegate: self.delegate, type: .password).unmask()
    }()

    private weak var delegate: LoginViewDelegate?

    let loginButton = UIButton(type: .roundedRect).unmask()

    init(frame: CGRect = .zero, delegate: LoginViewDelegate) {

        self.delegate = delegate

        super.init(frame: frame)
        
        self.configureView()
        self.configureSubViews()
        self.defineConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }

    func shiftCenter(by value: CGFloat, animated: Bool, toHide: Bool) {

        let valueDirection = toHide ? -value : value

        let usernameBlock: () -> Void = { self.usernameTextField.center.x += valueDirection }
        let passwordBlock: () -> Void = { self.passwordTextField.center.x += valueDirection }
        let loginButtonBlock: () -> Void = { self.loginButton.center.x += valueDirection }

        if animated {

            self.animate(usernameBlock, delay: Constants.animation.duration/3)
            self.animate(passwordBlock, delay: Constants.animation.duration/2)
            self.animate(loginButtonBlock, delay: Constants.animation.duration)

        } else {

            usernameBlock()
            passwordBlock()
            loginButtonBlock()
        }
    }
}

// MARK: - Private
private extension LoginView {
    
    func configureView() {
        
        self.loginButton.addTarget(self.delegate, action: #selector(self.delegate?.loginButtonPressed), for: .touchUpInside)
        
        self.add(self.usernameTextField, self.passwordTextField, self.loginButton)
    }
    
    func configureSubViews() {

        self.loginButton.layer.cornerRadius = Constants.cornerRadius
        self.loginButton.layer.shouldRasterize = true
        self.loginButton.layer.rasterizationScale = UIScreen.main.scale

        self.loginButton.titleLabel?.font = Constants.button.font

        self.loginButton.setTitle(Constants.button.text, for: .normal)

        self.loginButton.setTitleColor(Constants.button.color, for: .normal)
        self.loginButton.setTitleColor(Constants.button.disabledColor, for: .disabled)

        self.loginButton.backgroundColor = Constants.button.backgroundColor

        self.loginButton.isEnabled = false
    }
    
    func defineConstraints() {
        
        self.usernameTextField.edge(onlyTo: [.top, .leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.passwordTextField.topAnchor.bind(to: self.usernameTextField.bottomAnchor).addSpace(Constants.horizontalMargin)
        self.passwordTextField.edge(onlyTo: [.leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.loginButton.topAnchor.bind(to: self.passwordTextField.bottomAnchor).addSpace(Constants.horizontalMargin)
        self.loginButton.edge(onlyTo: [.leading, .trailing, .bottom], to: self, insets: [.all(Constants.margin)])
    }

    func animate(_ block: @escaping () -> Void, delay: TimeInterval) {

        UIView.animate(withDuration: Constants.animation.duration,
                       delay: delay,
                       usingSpringWithDamping: Constants.animation.spring,
                       initialSpringVelocity: Constants.animation.speed,
                       options: .curveEaseInOut,
                       animations: block,
                       completion: nil)
    }
}
