//
//  APIRequest.swift
//  PM2_storyboardLoginConexionAPI
//
//  Created by Gerardo on 20/02/20.
//  Copyright © 2020 Gerardo. All rights reserved.
//

import Foundation

enum APIError:Error {
    case responseProblems
    case encodingProblems
    case decodingProblems
}

struct tet: Codable {
    var id:Int?
    
    var usuario:String?
    var password:String?
    
    var next:String?
    var previous:String?
    

}



struct APIRequest{
    let resourceURL: URL
    
    init(endpoint: String) {
        let baseURL = "http://127.0.0.1:8000/apiLogin/\(endpoint)/"
        guard let resourceURL = URL(string: baseURL) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save(_ dataToSave: Datos, completion: @escaping(Result<String, APIError>) -> Void){
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "Post"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(dataToSave)
            
            let task = URLSession.shared.dataTask(with: urlRequest){
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 201 else {
                        completion(.failure(.responseProblems))
                        return
                }
            completion(.success("Success"))
            }
            task.resume()
        }catch{
            completion(.failure(.encodingProblems))
        }
    }
    
    
    func get(_ dataToSave: Datos, completion: @escaping(Result<Datos, APIError>) -> Void){
            do {
                var urlRequest = URLRequest(url: resourceURL)
                urlRequest.httpMethod = "Get"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: urlRequest){
                    data, response, _ in
                    guard let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200, let JSONData = data else {
                            completion(.failure(.responseProblems))
                            return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let contentData = try decoder.decode (Datos.self, from: JSONData)
    //                    let contentData = try JSONDecoder().decode(Datos.self, from: JSONData)
                        completion(.success(contentData))
                    }catch {
                        completion(.failure(.decodingProblems))
                    }
                }
                task.resume()
            }catch{
                completion(.failure(.encodingProblems))
            }
        }
    
    func update(_ dataToUpdate: Datos, completion: @escaping(Result <String, APIError>) -> Void){
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "Put"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(dataToUpdate)
            
            let task = URLSession.shared.dataTask(with: urlRequest){
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 204 else {
                        completion(.failure(.responseProblems))
                        return
                }
                completion(.success("Success"))
            }
            task.resume()
            
        }catch{
            completion(.failure(.encodingProblems))
        }
    }
    
    func delete(completion: @escaping(Result<String, APIError>) -> Void){
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "Delete"
            
            let task = URLSession.shared.dataTask(with: urlRequest){
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 204 else {
                        completion(.failure(.decodingProblems))
                        return
                }
                completion(.success("Success"))
            }
            task.resume()
            
        }catch{
            completion(.failure(.encodingProblems))
        }
    }
    
}
