//
//  Token.swift
//  Elo Rate
//
//  Created by João Campos on 04/11/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

final class Token: Codable {
    
    let value: String
    
    enum CodingKeys: String, CodingKey {
        
        case value = "token"
    }
}
