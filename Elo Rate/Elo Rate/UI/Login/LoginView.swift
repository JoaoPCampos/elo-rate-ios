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
        static let textColor: UIColor = .black
        static let horizontalMargin: LayoutKitMargin = .offset(10)
        static let margin: CGFloat = 24
        static let cornerRadius: CGFloat = 4
        static let insets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    let usernameTextField = BaseTextField(padding: Constants.insets)
    let passwordTextField = BaseTextField(padding: Constants.insets)
    let loginButton = UIButton()
    
    convenience init() {
        
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.unmask()
        self.defineSubViews()
        self.defineConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    
    func defineSubViews() {
        
        self.add(self.usernameTextField, self.passwordTextField, self.loginButton)
        
        self.usernameTextField.placeholder = Constants.usernamePlaceholder
        self.passwordTextField.placeholder = Constants.passwordPlaceholder
        
        self.usernameTextField.textColor = Constants.textColor
        self.passwordTextField.textColor = Constants.textColor
        
        [self.usernameTextField, self.passwordTextField, self.loginButton].forEach {
            
            $0.unmask()
            $0.backgroundColor = .white
            $0.layer.cornerRadius = Constants.cornerRadius
            $0.layer.shouldRasterize = true
            $0.layer.rasterizationScale = UIScreen.main.scale
        }
        
        self.loginButton.setTitle(Constants.loginButtonText, for: .normal)
        self.loginButton.setTitleColor(Constants.textColor, for: .normal)
        self.loginButton.setTitleColor(.gray, for: .selected)
    }
    
    func defineConstraints() {
        
        self.usernameTextField.edge(onlyTo: [.top, .leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.passwordTextField.topAnchor.bind(to: self.usernameTextField.bottomAnchor).addSpace(Constants.horizontalMargin)
        self.passwordTextField.edge(onlyTo: [.leading, .trailing], to: self, insets: [.all(Constants.margin)])
        
        self.loginButton.topAnchor.bind(to: self.passwordTextField.bottomAnchor).addSpace(Constants.horizontalMargin)
        self.loginButton.edge(onlyTo: [.leading, .trailing, .bottom], to: self, insets: [.all(Constants.margin)])
    }
}