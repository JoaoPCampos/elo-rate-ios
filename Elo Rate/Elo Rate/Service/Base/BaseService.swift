//
//  BaseService.swift
//  Elo Rate
//
//  Created by João Campos on 18/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService
import Foundation

class BaseService: ServiceProtocol {
    
    let basePath: String = "jocs-elo.herokuapp.com/ranking/api/"
    
    let endpoint: ServiceEndpoint
    let method: Request.Method
    let parameters: [URLQueryItem]?
    let headers: [Header]
    
    static func get(_ endpoint: ServiceEndpoint,
                    parameters: [URLQueryItem]? = nil,
                    headers: Header...) -> BaseService {
        
        return BaseService(endpoint: endpoint,
                           method: .get,
                           parameters: parameters,
                           headers: headers)
    }
    
    static func post(_ endpoint: ServiceEndpoint,
                     parameters: [URLQueryItem]? = nil,
                     headers: Header...) -> BaseService {
        
        return BaseService(endpoint: endpoint,
                           method: .post,
                           parameters: parameters,
                           headers: headers)
    }
    
    static func put(_ endpoint: ServiceEndpoint,
                    parameters: [URLQueryItem]? = nil,
                    headers: Header...) -> BaseService {
        
        return BaseService(endpoint: endpoint,
                           method: .put,
                           parameters: parameters,
                           headers: headers)
    }
    
    static func delete(_ endpoint: ServiceEndpoint,
                       parameters: [URLQueryItem]? = nil,
                       headers: Header...) -> BaseService {
        
        return BaseService(endpoint: endpoint,
                           method: .delete,
                           parameters: parameters,
                           headers: headers)
    }
    
    private init(endpoint: ServiceEndpoint,
                 method: Request.Method,
                 parameters: [URLQueryItem]? = nil,
                 headers: [Header]) {
        
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
