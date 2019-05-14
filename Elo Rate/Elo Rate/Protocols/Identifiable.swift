//
//  Identifiable.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

protocol Identifiable {

    var name: String { get }

    static var identifier: String { get }
}

//MARK:- UIVIEWCONTROLLER
extension Identifiable where Self: UIViewController {

    var name: String {

        return String(describing: type(of: self))
    }

    static var identifier: String {

        return String(describing: self)
    }
}
