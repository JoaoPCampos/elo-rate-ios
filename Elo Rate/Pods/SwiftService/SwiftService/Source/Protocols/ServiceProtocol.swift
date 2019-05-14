//
//  ServiceProtocol.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//

import Foundation

public protocol ServiceProtocol {
    
    var path: String { get }
    var method: Request.Method { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [(key: Request.Header, value: String)] { get }
}
