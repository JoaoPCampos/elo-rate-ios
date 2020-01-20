//
//  ServiceProtocol.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//

import Foundation

public protocol ServiceProtocol {
    
    typealias Header = (key: Request.Header, value: String)
    
    var endpoint: ServiceEndpoint { get }
    var basePath: String { get }
    var method: Request.Method { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [Header] { get }
}

extension ServiceProtocol {
    
    var path: String {
        
        return self.endpoint.scheme.description + self.basePath + self.endpoint.path
    }
}
