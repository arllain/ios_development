//
//  REST.swift
//  Carangas
//
//  Created by aluno on 03/09/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

enum RESTOperation {
    case save
    case update
    case delete
}

class REST {
    
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    // session criada automaticamente e disponivel para reusar
    private static let session = URLSession(configuration: configuration) // URLSession.shared
    
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 10.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    static func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        
        // tarefa criada, mas nao processada
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            // 1
            if error == nil {
                // 2
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    
                    // servidor respondeu com sucesso :)
                    // 3
                    // obter o valor de data
                    guard let data = data else {
                        onError(.noData)
                        return
                    }
                    
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    } catch {
                        // algum erro ocorreu com os dados
                        onError(.invalidJSON)
                    }
                    
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        // start request
        dataTask.resume()
        
    }

    
    static func save(car: Car, onComplete: @escaping (Bool) -> Void ) {
        applyOperation(car: car, operation: .save, onComplete: onComplete)
    }
    
    
    static func update(car: Car, onComplete: @escaping (Bool) -> Void ) {
        // chamando o update passando operation
        applyOperation(car: car, operation: .update, onComplete: onComplete)
    }
    
    class func delete(car: Car, onComplete: @escaping (Bool) -> Void ) {
        applyOperation(car: car, operation: .delete, onComplete: onComplete)
    }
    
    private static func applyOperation(car: Car, operation: RESTOperation , onComplete: @escaping (Bool) -> Void ) {
        
        // o endpoint do servidor para update é: URL/id
        let urlString = basePath + "/" + (car._id ?? "")
        
        guard let url = URL(string: urlString) else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        var httpMethod: String = ""
        
        switch operation {
        case .delete:
            httpMethod = "DELETE"
        case .save:
            httpMethod = "POST"
        case .update:
            httpMethod = "PUT"
        }
        request.httpMethod = httpMethod
        
        // transformar objeto para um JSON, processo contrario do decoder -> Encoder
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                // verificar e desembrulhar em uma unica vez
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                
                // ok
                onComplete(true)
                
            } else {
                onComplete(false)
            }
        }
        
        dataTask.resume()
    }

    
}
