//
//  ServiceError.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//

import Foundation

public final class ServiceError: Error {
    
    public enum ErrorType: Int {
        
        case missing = 409
        case forbidden = 403
        case not_allowed = 405
        case invalid = 401
        case unknown
    }
    
    // MARK: - Properties
    public let type: ErrorType
    public let message: String

    public init() {
        
        self.type = .unknown
        self.message = "No Message"
    }

    public init(type: ErrorType, message: String) {
        
        self.type = type
        self.message = message
    }

    public init(code: Int, dictionary: [String: Any]) {
        
        self.type = ErrorType.init(rawValue: code) ?? .unknown
        self.message = (dictionary["message"] as? String) ?? "No Message"
    }
}
