//
//  NSLayoutDimensionExtension.swift
//  LayoutKit
//
//  Created by João Campos on 12/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

public extension NSLayoutDimension {
    
    @discardableResult
    func bind(_ relation: NSLayoutConstraint.Relation = .equal,
              to constant: CGFloat,
              prio: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
            
        case .equal:
            
            constraint = self.constraint(equalToConstant: constant)
            
        case .greaterThanOrEqual:
            
            constraint = self.constraint(greaterThanOrEqualToConstant: constant)
            
        case .lessThanOrEqual:
            
            constraint = self.constraint(lessThanOrEqualToConstant: constant)
        
        @unknown default:
            
            fatalError()
        }
        
        constraint.isActive = true
        constraint.priority = prio
        
        return constraint
    }
}
