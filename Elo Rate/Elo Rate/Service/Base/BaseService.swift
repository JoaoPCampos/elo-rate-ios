//
//  BaseService.swift
//  Elo Rate
//
//  Created by João Campos on 18/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService
import Foundation

final class BaseService: ServiceProtocol {
    
    internal let basePath: String = "jocs-elo.herokuapp.com/ranking/api/v1.0/"
    
    let endpoint: ServiceEndpoint
    let method: Request.Method
    let parameters: [URLQueryItem]?
    let headers: [Header]
    
    init(_ endpoint: ServiceEndpoint,
         method: Request.Method,
         parameters: [URLQueryItem]? = nil,
         headers: Header...) {
        
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
