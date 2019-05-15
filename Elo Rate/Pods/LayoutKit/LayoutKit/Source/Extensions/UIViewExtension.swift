//
//  UIViewExtension.swift
//  LayoutKit
//
//  Created by João Campos on 12/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

extension UIView: LayoutKitProtocol {}

public extension UIView {

    @discardableResult
    static func unmask() -> Self {

        let object = self.init()

        object.translatesAutoresizingMaskIntoConstraints = false

        return object
    }

    @discardableResult
    func unmask() -> Self {

        self.translatesAutoresizingMaskIntoConstraints = false

        return self
    }
}
