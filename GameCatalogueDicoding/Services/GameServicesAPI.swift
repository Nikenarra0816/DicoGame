//
//  GameServices.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 02/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

class GameServiceApi {
    public static let shared = GameServiceApi()
    
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: Constant.Url.gameUrl)!
    
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // Enum Endpoint
    enum Endpoint: String, CaseIterable {
        case list = "games"
    }
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
//        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
//        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
     
        urlSession.dataTask(with: url) { (result) in
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        
                        let values = try self.jsonDecoder.decode(T.self, from: data)
                        
                        completion(.success(values))
                    } catch {
                        print("Decode Error")
                        completion(.failure(.decodeError))
                    }
                case .failure( _):
                        completion(.failure(.apiError))
                    }
         }.resume()
    }
    
    public func fetchMovies(page: Int = 1,pageSize: Int = 10, query: String, from endpoint: Endpoint, result: @escaping (Result<GameResponse, APIServiceError>) -> Void) {
        var movieURL = baseURL
            .appendingPathComponent("api")
            .appendingPathComponent(endpoint.rawValue)
            .appending("page_size", value: String(pageSize))
            .appending("page", value: String(page))
        
        if query != "" {
            movieURL = movieURL.appending("search", value: query)
        }
            
        fetchResources(url: movieURL, completion: result)
        
        print(movieURL)
    }
    
    public func fetchDetail(id: Int, result: @escaping(Result<Game, APIServiceError>) -> Void) {
        
        let movieURL = baseURL
            .appendingPathComponent("api")
            .appendingPathComponent(Endpoint.list.rawValue)
            .appendingPathComponent(String(id))
        
        fetchResources(url: movieURL, completion: result)
        
    }
}
