//
//  PlayerService.swift
//  Elo Rate
//
//  Created by João Campos on 05/03/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import SwiftService

final class PlayerService: Service {
    
    static func create(username: String,
                       email: String,
                       password: String,
                       success: @escaping (Player) -> Void,
                       failure: @escaping (ServiceError) -> Void) {
        
        let body = [Body.username: username, Body.email: email, Body.password: password].asData
        
        let createPlayer = ServiceEndpoint(path: PlayerCreation.path, body: body)
        
        let service: Service = .post(createPlayer)
        
        ServiceManager<Player>(service: service).request(success: success, failure: failure)
    }
}

// MARK: - Private
private extension PlayerService {
    
    enum Body {
        
        static let username: String = "username"
        static let email: String = "email"
        static let password: String = "password"
    }
    
    enum PlayerCreation {
        
        static let path: String = "player"
    }
}
