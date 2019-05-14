//
//  ServicePagination.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

public final class ServicePagination: ServicePaginationProtocol {

    public let take: Int
    public private(set) var skip: Int
    public private(set) var total: Int

    public init(take: Int, skip: Int, total: Int) {
        
        self.take = take
        self.skip = skip
        self.total = total
    }
    
    public func update(with total: Int) {
        
        self.total = total
        
        if self.shouldFetch() {
            
            self.skip = self.skip + self.take
        }
    }
}
