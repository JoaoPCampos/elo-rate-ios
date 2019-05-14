//
//  AppDelegate.swift
//  Elo Rate
//
//  Created by João Campos on 14/08/2018.
//  Copyright © 2018 João Campos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK:- Properties
    var window: UIWindow?
    var appCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        return self.setupWindow()
    }
}

// MARK: - Private
private extension AppDelegate {

    func setupWindow() -> Bool {

        self.window = UIWindow()

        guard let window = self.window else { return false }

        self.appCoordinator = AppCoordinator(window: window)

        self.appCoordinator?.start()

        return true
    }
}

