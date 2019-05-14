//
//  LayoutKitProtocol+Extension.swift
//  LayoutKit
//
//  Created by João Campos on 17/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

public extension LayoutKitProtocol {
    
    @discardableResult
    func edge(_ relation: NSLayoutConstraint.Relation = .equal,
              to item: LayoutKitProtocol,
              insets: [UIEdgeInsets] = [],
              prio: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        let inset: UIEdgeInsets = insets.isEmpty ? .zero : self.edgeInset(combining: insets)
        
        return self.internalEdge(relation, edges: LayoutKitAttribute.allCases, to: item, inset: inset, prio: prio)
    }
    
    @discardableResult
    func edge(onlyTo edges: [LayoutKitAttribute],
              as relation: NSLayoutConstraint.Relation = .equal,
              to item: LayoutKitProtocol,
              insets: [UIEdgeInsets] = [],
              prio: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        let inset: UIEdgeInsets = insets.isEmpty ? .zero : self.edgeInset(combining: insets, filter: edges)
        
        return self.internalEdge(relation, edges: edges, to: item, inset: inset, prio: prio)
    }
    
    @discardableResult
    func center(_ relation: NSLayoutConstraint.Relation = .equal,
                in item: LayoutKitProtocol,
                add margin: LayoutKitMargin = .zero,
                prio: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        return [
            self.centerXAnchor.bind(relation, to: item.centerXAnchor, prio: prio).addSpace(margin),
            self.centerYAnchor.bind(relation, to: item.centerYAnchor, prio: prio).addSpace(margin)
        ]
    }
    
    @discardableResult
    func size(_ relation: NSLayoutConstraint.Relation = .equal,
              to attributes: LayoutKitSizeAttribute...,
              prio: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        guard attributes.isEmpty == false else { return [] }
        
        return attributes.map {
            
            switch $0 {
                
            case .height(let value):
                
                return self.heightAnchor.bind(relation, to: value, prio: prio)
                
            case .width(let value):
                
                return self.widthAnchor.bind(relation, to: value, prio: prio)
            }
        }
    }
}
