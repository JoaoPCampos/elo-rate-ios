//
//  Player.swift
//  Elo Rate
//
//  Created by João Campos on 19/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

final class Player: Codable {
    
    let id: UInt?
    let username: String
    let email: String
    
    private let password: String
    
    init(username: String, email: String, password: String) {
        
        self.id = nil
        self.username = username
        self.email = email
        self.password = password
    }
}
