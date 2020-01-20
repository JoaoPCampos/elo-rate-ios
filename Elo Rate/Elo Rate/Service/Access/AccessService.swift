//
//  AccessService.swift
//  Elo Rate
//
//  Created by João Campos on 18/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService

enum AccessService: BaseServiceProtocol {
    
    case create(player: Player)
    case login(username: String, password: String)
    case recover(email: String)
    case logout
}

extension AccessService {
    
    var baseService: BaseService {
        
        switch self {
            
        case .create(let player):
            
            let body = try? JSONEncoder().encode(player)
            let create = ServiceEndpoint(path: "player", body: body)
            
            return BaseService(create, method: .post)
            
        case .login(let username, let password):
            
            let login = ServiceEndpoint(path: "auth/login")
            let basicAuthHeader = ServiceProtocol.Header(.authorization, username + ":" + password)
            
            return BaseService(login, method: .post, headers: basicAuthHeader)
            
        case .recover(let email):
            
            let recover = ServiceEndpoint(path: "auth/recover")
            let query = URLQueryItem(name: "email", value: email)
            
            return BaseService(recover, method: .post, parameters: [query])
            
        case .logout:
            
            let logout = ServiceEndpoint(path: "auth/logout")
            
            return BaseService(logout, method: .delete)
        }
    }
}
