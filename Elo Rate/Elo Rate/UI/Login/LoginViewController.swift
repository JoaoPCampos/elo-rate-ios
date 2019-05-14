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

    override func viewDidLoad() {

        super.viewDidLoad()

        self.defineSubViews()
        self.defineConstraints()
    }
}

private extension LoginViewController {

    func defineSubViews() {

        let loginView = LoginView()
        
        self.view.addSubview(loginView)
        
        loginView.center(in: self.view)
        loginView.edge(onlyTo: [.leading, .trailing], to: self.view)
    }

    func defineConstraints() {

        // TODO
    }
}
