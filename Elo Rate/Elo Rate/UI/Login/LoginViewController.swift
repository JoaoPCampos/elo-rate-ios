//
//  LoginViewController.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {

    var viewModel: LoginViewModel?

    private let loginView = LoginView()

    override func viewDidLoad() {

        super.viewDidLoad()

        self.defineSubViews()
        self.defineConstraints()
    }
}

private extension LoginViewController {

    func defineSubViews() {
        
        self.view.addSubview(self.loginView)
    }

    func defineConstraints() {

        self.loginView.center(in: self.view)
        self.loginView.edge(onlyTo: [.leading, .trailing], to: self.view)
    }
}
