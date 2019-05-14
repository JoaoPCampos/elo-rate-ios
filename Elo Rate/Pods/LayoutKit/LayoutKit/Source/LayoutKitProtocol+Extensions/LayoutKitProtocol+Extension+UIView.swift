//
//  LayoutKitProtocol+Extension+UIView.swift
//  LayoutKit
//
//  Created by João Campos on 17/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

public extension LayoutKitProtocol where Self: UIView {
    
    @discardableResult
    func edgeToSuperview(_ relation: NSLayoutConstraint.Relation = .equal,
                         insets: [UIEdgeInsets] = [],
                         prio: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        guard let superview = self.superview else { return [] }
        
        let inset: UIEdgeInsets = insets.isEmpty ? .zero : self.edgeInset(combining: insets)
        
        return self.internalEdge(relation, edges: LayoutKitAttribute.allCases, to: superview, inset: inset, prio: prio)
    }
    
    @discardableResult
    func centerInSuperView(as relation: NSLayoutConstraint.Relation = .equal,
                           add margin: LayoutKitMargin = .zero,
                           prio: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        guard let superView = self.superview else { return [] }
        
        return [
            self.centerXAnchor.bind(relation, to: superView.centerXAnchor, prio: prio).addSpace(margin),
            self.centerYAnchor.bind(relation, to: superView.centerYAnchor, prio: prio).addSpace(margin)
        ]
    }
}
