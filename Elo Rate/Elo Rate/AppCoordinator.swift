//
//  AppCoordinator.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {

    private var window: UIWindow

    var coordinators: [Coordinator] = []

    var releaseCoordinator: ((Coordinator) -> Void)?

    init(window: UIWindow) {

        self.window = window
    }

    func start() {

        let accessCoordinator = AccessCoordinator(coordinators: [], window: window)

        accessCoordinator.start()

        self.didStartExecution(onCoordinator: accessCoordinator)
    }
}
