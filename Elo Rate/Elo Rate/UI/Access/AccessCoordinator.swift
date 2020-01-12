//
//  AccessCoordinator.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

final class AccessCoordinator: Coordinator {

    // MARK:- Properties
    private var window: UIWindow
    private let navigationController: UINavigationController

    var coordinators: [Coordinator]
    var releaseCoordinator: ((Coordinator) -> Void)?

    init(coordinators: [Coordinator], window: UIWindow) {

        self.coordinators = coordinators
        self.window = window
        self.navigationController = UINavigationController().black()
    }

    func start() {

        self.navigationController.pushViewController(AccessViewController(),
                                                     animated: true)

        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
}
