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

    private let loginView = LoginView().unmask()

    override func viewDidLoad() {

        super.viewDidLoad()

        self.defineSubViews()
        self.defineConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        self.loginView.layoutIfNeeded()

        self.loginView.shiftCenter(by: self.view.bounds.width, animated: false, toHide: true)
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        self.loginView.shiftCenter(by: self.view.bounds.width, animated: true, toHide: false)
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
