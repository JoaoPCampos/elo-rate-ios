//
//  ServicePaginationProtocol.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

public protocol ServicePaginationProtocol {
    
    var nextPage: Int { get }
    var skip: Int { get }
    var take: Int { get }
    var total: Int { get }
    
    func shouldFetch() -> Bool
    mutating func update(with total: Int)
}

public extension ServicePaginationProtocol {
    
    var nextPage: Int {
        
        return take + skip
    }
    
    func shouldFetch() -> Bool {
        
        return nextPage <= total
    }
}
