//
//  UINavigationController+Extension.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

extension UINavigationController {

    func black() -> UINavigationController {

        self.navigationBar.barTintColor = .nero
        self.navigationBar.barStyle = .black
        UINavigationBar.appearance().tintColor = .brilliance

        return self
    }
}
