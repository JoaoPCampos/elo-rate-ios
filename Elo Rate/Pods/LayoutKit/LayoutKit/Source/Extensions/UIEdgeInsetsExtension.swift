//
//  UIEdgeInsetsExtension.swift
//  layout-kit-framework
//
//  Created by João Campos on 15/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

public typealias LayoutKitEdge = UIEdgeInsets

public extension LayoutKitEdge {
    
    static func top(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: value, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    static func leading(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: value, bottom: 0.0, right: 0.0)
    }
    
    static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: value, right: 0.0)
    }
    
    static func trailing(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: value)
    }
    
    static func vertical(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: value, left: 0.0, bottom: value, right: 0.0)
    }
    
    static func horizontal(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: value, bottom: 0.0, right: value)
    }
    
    static func all(_ value: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
