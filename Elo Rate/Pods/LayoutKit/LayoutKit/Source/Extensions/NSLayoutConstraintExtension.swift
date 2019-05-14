//
//  NSLayoutConstraintExtension.swift
//  LayoutKit
//
//  Created by João Campos on 12/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    @discardableResult
    func addSpace(_ margin: LayoutKitMargin) -> NSLayoutConstraint {

        switch margin {
        
        case .inset(let value):
            
            self.constant =  self.invert ? value : -value
            
        case .offset(let value):
            
            self.constant =  self.invert ? -value : value

        case .zero:

            return self
        }
        
        return self
    }
    
    @discardableResult
    func enable() -> NSLayoutConstraint {
        
        self.isActive = true
        
        return self
    }
    
    @discardableResult
    func disable() -> NSLayoutConstraint {
        
        self.isActive = false
        
        return self
    }
}

internal extension NSLayoutConstraint {
    
    private var invert: Bool {
        
        let areEqual = self.firstAttribute == self.secondAttribute
        let areTopOrLeading = self.firstAttribute == .top || self.firstAttribute == .leading
        
        return areEqual && areTopOrLeading
    }
}
