//
//  UIView+Extension.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

extension UIView {
    
    func unmask()  {
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func add(_ views: UIView...) {
        
        views.forEach {
            
            self.addSubview($0)
        }
    }
}
