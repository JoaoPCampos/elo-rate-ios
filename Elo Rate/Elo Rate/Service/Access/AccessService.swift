//
//  AccessService.swift
//  Elo Rate
//
//  Created by João Campos on 18/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService

final class AccessService {
    
    static func login(username: String,
                      password: String,
                      success: @escaping (Token) -> Void,
                      failure: @escaping (ServiceError) -> Void) {
        
        let login = ServiceEndpoint(path: Authentication.login.path)
        let basicAuth = (username + ":" + password).basicAuth
        let basicAuthHeader = ServiceProtocol.Header(.authorization, basicAuth)
        let service: Service = .post(login, headers: basicAuthHeader)
        
        ServiceManager<Token>(service: service).request(success: success, failure: failure)
    }
    
    static func recover(email: String,
                        success: @escaping (Blank) -> Void,
                        failure: @escaping (ServiceError) -> Void) {
        
        let recoverPassword = ServiceEndpoint(path: Authentication.recover.path)
        let query = URLQueryItem(name: Query.email, value: email)
        let service: Service = .post(recoverPassword, parameters: [query])
        
        ServiceManager<Blank>(service: service).request(success: success, failure: failure)
    }
    
    static func logout(success: @escaping (Blank) -> Void,
                       failure: @escaping (ServiceError) -> Void) {
        
        let logout = ServiceEndpoint(path: Authentication.logout.path)
        let service: Service = .delete(logout)
        
        ServiceManager<Blank>(service: service).request(success: success, failure: failure)
    }
}

// MARK: - Private
private extension AccessService {
    
    enum Query {
        
        static let email: String = "email"
    }
    
    enum Authentication: String {
        
        case login
        case recover
        case logout
        
        var path: String {
            
            return Authentication.base + self.rawValue
        }
        
        private static let base: String = "auth/"
    }
}
