//
//  LayoutKitProtocol+Internal+Extension.swift
//  LayoutKit
//
//  Created by João Campos on 17/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

internal extension LayoutKitProtocol {
    
    func edgeInset(combining insets: [UIEdgeInsets], filter: [LayoutKitAttribute] = []) -> UIEdgeInsets {

        let top = insets.map({ $0.top }).reduce(0, +)
        let bottom = insets.map({ $0.bottom }).reduce(0, +)
        let left = insets.map({ $0.left }).reduce(0, +)
        let right = insets.map({ $0.right }).reduce(0, +)

        guard filter.isEmpty else {

            let combinedTop = filter.contains(.top) ? top : 0
            let combinedBottom = filter.contains(.bottom) ? bottom : 0
            let combinedLeading = filter.contains(.leading) ? left : 0
            let combinedTrailing = filter.contains(.trailing) ? right : 0

            return UIEdgeInsets(top: combinedTop, left: combinedLeading, bottom: combinedBottom, right: combinedTrailing)
        }
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func internalEdge(_ relation: NSLayoutConstraint.Relation,
                      edges: [LayoutKitAttribute],
                      to item: LayoutKitProtocol,
                      inset: UIEdgeInsets,
                      prio: UILayoutPriority) -> [NSLayoutConstraint] {
        
        return edges.map {
            
            let constraint: NSLayoutConstraint
            let margin: LayoutKitMargin
            
            switch $0 {
                
            case .top:

                margin = .inset(inset.top)
                constraint = self.topAnchor.bind(relation,
                                                 to: item.topAnchor,
                                                 prio: prio).addSpace(margin)
                
            case .bottom:

                margin = .inset(inset.bottom)
                constraint = self.bottomAnchor.bind(relation,
                                                    to: item.bottomAnchor,
                                                    prio: prio).addSpace(margin)
                
            case .leading:

                margin = .inset(inset.left)
                constraint = self.leadingAnchor.bind(relation,
                                                     to: item.leadingAnchor,
                                                     prio: prio).addSpace(margin)
                
            case .trailing:

                margin = .inset(inset.right)
                constraint = self.trailingAnchor.bind(relation,
                                                      to: item.trailingAnchor,
                                                      prio: prio).addSpace(margin)
            }
            
            return constraint
        }
    }
}
