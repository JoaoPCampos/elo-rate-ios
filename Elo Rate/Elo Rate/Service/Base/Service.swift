//
//  Service.swift
//  Elo Rate
//
//  Created by João Campos on 18/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService
import Foundation

class Service: ServiceProtocol {
    
    let basePath: String = "jocs-elo.herokuapp.com/ranking/api/"
    
    let endpoint: ServiceEndpoint
    let method: Request.Method
    let parameters: [URLQueryItem]?
    let headers: [Header]
    
    private init(_ method: Request.Method,
                 endpoint: ServiceEndpoint,
                 parameters: [URLQueryItem]? = nil,
                 headers: [Header]) {
        
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    static func get(_ endpoint: ServiceEndpoint, parameters: [URLQueryItem]? = nil, headers: Header...) -> Service {
        
        return Service(.get, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    
    static func post(_ endpoint: ServiceEndpoint, parameters: [URLQueryItem]? = nil, headers: Header...) -> Service {
        
        return Service(.post, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    
    static func put(_ endpoint: ServiceEndpoint, parameters: [URLQueryItem]? = nil, headers: Header...) -> Service {
        
        return Service(.put, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    
    static func delete(_ endpoint: ServiceEndpoint, parameters: [URLQueryItem]? = nil, headers: Header...) -> Service {
        
        return Service(.delete, endpoint: endpoint, parameters: parameters, headers: headers)
    }
}
