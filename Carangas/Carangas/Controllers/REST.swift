//
//  REST.swift
//  Carangas
//
//  Created by aluno on 03/09/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation

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
    
    class func loadCars() {
        
        guard let url = URL(string: basePath) else {return}
        
        // tarefa criada, mas nao processada
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            // 1
            if error == nil {
                // 2
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    
                    // servidor respondeu com sucesso :)
                    // 3
                    // obter o valor de data
                    guard let data = data else {return}
                    
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        // pronto para reter dados
                        
                        for car in cars {
                            print("\(car.name) - \(car.brand)")
                        }
                        
                    } catch {
                        // algum erro ocorreu com os dados
                        print(error.localizedDescription)
                    }
                    
                } else {
                    print("Algum status inválido(-> \(response.statusCode) <-) pelo servidor!! ")
                }
            } else {
                print(error.debugDescription)
            }
        }
        // start request
        dataTask.resume()
        
    }}
