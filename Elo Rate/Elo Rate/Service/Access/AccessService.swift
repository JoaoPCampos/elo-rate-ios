//
//  AccessService.swift
//  Elo Rate
//
//  Created by João Campos on 18/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService

final class AccessService: BaseService {
    
    static func create(username: String, email: String, password: String) -> BaseService {
        
        let body = ["username": username, "email": email, "password": password].data
        
        let createPlayer = ServiceEndpoint(path: "player", body: body)
        
        return .post(createPlayer)
    }
    
    static func login(username: String, password: String) -> BaseService {
        
        let login = ServiceEndpoint(path: "auth/login")
        let basicAuth = (username + ":" + password).basicAuth
        
        let basicAuthHeader = ServiceProtocol.Header(.authorization, basicAuth)
        
        return .post(login, headers: basicAuthHeader)
    }
    
    static func recover(email: String) -> BaseService {
        
        let recoverPassword = ServiceEndpoint(path: "auth/recover")
        let query = URLQueryItem(name: "email", value: email)
        
        return .post(recoverPassword, parameters: [query])
    }
    
    static var logout: BaseService {
        
        let logout = ServiceEndpoint(path: "auth/logout")
        
        return .delete(logout)
    }
}
