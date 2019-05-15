//
//  BaseViewController.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK:- DEINIT
    deinit {

        print(self.name + " was deallocated")
    }
}

//MARK:- PROTOCOL Identifiable
extension BaseViewController: Identifiable {}
