//
//  String+Extension.swift
//  Elo Rate
//
//  Created by João Campos on 19/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

extension String {
    
    var basicAuth: String {
        
        guard let encodingData = self.data(using: .utf8) else {
            
            preconditionFailure("Unable to encode credentials")
        }
        
        return "Basic " + encodingData.base64EncodedString(options: .lineLength64Characters)
    }
}
