//
//  AccessViewController.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import SwiftService

final class AccessViewController: BaseViewController {

    private lazy var accessLoginView = {
        
        return AccessLoginView(delegate: self).unmask()
    }()

    override func viewDidLoad() {

        super.viewDidLoad()

        self.defineSubViews()
        self.defineConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        self.accessLoginView.hide()
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        self.accessLoginView.popIn(delay: 0.5)
    }
}

// MARK: - Private
private extension AccessViewController {

    func defineSubViews() {
        
        self.view.addSubview(self.accessLoginView)
    }

    func defineConstraints() {

        self.accessLoginView.edge(onlyTo: [.leading, .trailing],
                                  to: self.view)
        
        self.accessLoginView.center(in: self.view)
    }
}

// MARK: - LoginViewDelegate
extension AccessViewController: AccessLoginViewDelegate {

    func loginButtonPressed() {
        
        //TODO all of this!
        struct Token: Codable {
            
            let token: String
        }
        
        let login = AccessService.login(username: "jocs", password: "123")
        
        ServiceManager<Token>(service: login, log: true).request(success: { token in
            
            print("\n\nYAY!\n\n")
        
        }) { error in
            
            print("\nerror\n")
        }
    }
}
