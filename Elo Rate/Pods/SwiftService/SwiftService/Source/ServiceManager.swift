//
//  ServiceManager.swift
//  SwiftService
//
//  Created by João Campos on 26/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

public class ServiceManager<T: Decodable> {
    
    private let service: ServiceProtocol
    
    public init(service: ServiceProtocol) {
        
        self.service = service
    }
}

// MARK: - Public
public extension ServiceManager {
    
    func request(success: @escaping (T?) -> Void,
                 failure: @escaping (Error?) -> Void) {
        
        guard var urlComponents = URLComponents(string: self.service.path) else { return }
        
        urlComponents.queryItems = self.service.parameters
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        
        for header in self.service.headers {
            
            request.addValue(header.value, forHTTPHeaderField: header.key.rawValue)
        }
        
        request.httpMethod = self.service.method.rawValue.uppercased()
        request.httpBody = self.service.endpoint.body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let httpStatus = response as? HTTPURLResponse, error == nil else {
                
                failure(error)
                
                return
            }
            
            if httpStatus.statusCode == 200 {
                
                success(self.decode(data))
                
            } else {
                
                if let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] {
                    
                    let serviceError = ServiceError(code: httpStatus.statusCode, dictionary: responseObject)
                    
                    failure(serviceError)
                    
                } else {
                    
                    failure(ServiceError())
                }
            }
        }
        
        task.resume()
    }
}

// MARK: - Private
private extension ServiceManager {
    
    func decode<T: Decodable>(_ data: Data?) -> T? {
        
        guard let data = data else { return nil }
        
        do {
            
            let jsonDecoder = JSONDecoder()
            
            let responseBody = try jsonDecoder.decode(T.self, from: data)
            
            return responseBody
        }
        catch {
            
            print("Decode failed with error:\n\(error)")
            
            return nil
        }
    }
}
