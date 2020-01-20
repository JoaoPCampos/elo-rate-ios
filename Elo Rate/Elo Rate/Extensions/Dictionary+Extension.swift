//
//  Dictionary+Extension.swift
//  Elo Rate
//
//  Created by João Campos on 20/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import UIKit

extension Dictionary where Key == String, Value == String {
    
    var data: Data? {
        
        return try? JSONEncoder().encode(self)
    }
}
