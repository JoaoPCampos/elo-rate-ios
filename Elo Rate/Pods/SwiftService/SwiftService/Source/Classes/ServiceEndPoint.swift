//
//  ServiceEndpoint.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

public final class ServiceEndpoint {
    
    public let scheme: Request.Scheme
    public let path: String
    public let body: Data?
    public let key: String?
    
    public init(scheme: Request.Scheme = .https,
                path: String,
                body: Data? = nil,
                key: String? = nil) {
        
        self.scheme = scheme
        self.path = path
        self.body = body
        self.key = key
    }
}
