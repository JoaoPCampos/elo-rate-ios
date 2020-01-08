//
//  AccessViewController.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

final class AccessViewController: BaseViewController {

    var viewModel: AccessViewModel?

    private lazy var loginView = { return LoginView(delegate: self).unmask() }()

    override func viewDidLoad() {

        super.viewDidLoad()

        self.defineSubViews()
        self.defineConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        self.loginView.hide()
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        self.loginView.popIn(delay: 0.5)
    }
}

// MARK: - Private
private extension AccessViewController {

    func defineSubViews() {
        
        self.view.addSubview(self.loginView)
    }

    func defineConstraints() {

        self.loginView.center(in: self.view)
        self.loginView.edge(onlyTo: [.leading, .trailing], to: self.view)
    }
}

// MARK: - LoginViewDelegate
extension AccessViewController: LoginViewDelegate {

    func didUpdate(_ field: BaseTextField) {

        guard let viewModel = self.viewModel else { return }

        viewModel.didUpdate(field)

        self.loginView.shouldEnableLoginButton(viewModel.shouldEnableLoginButton())
    }

    func loginButtonPressed() {

        self.viewModel?.login()
        
        self.loginView.popIn()
    }
}
