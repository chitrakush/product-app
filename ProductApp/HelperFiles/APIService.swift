//
//  APIService.swift
//  ProductApp
//
//  Created by Chitra on 05/02/26.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case decodingError
    case noInternet
    case invalidResponse
    case serverError
}

protocol APIServiceProtocol {
    func fetchProducts(page: Int, completion: @escaping (Result<ProductResponse, APIError>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchProducts(
            page: Int,
            completion: @escaping (Result<ProductResponse, APIError>) -> Void
        ) {
            guard NetworkMonitor.shared.isConnected else {
                completion(.failure(.noInternet))
                return
            }
//            Using below url without category filter because the url given in the assignment doc does not have enough products to show paginated results
            let urlString = "https://fakeapi.net/products?page=\(page)&limit=10"
            guard let url = URL(string: urlString) else {
                completion(.failure(.invalidUrl))
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    completion(.failure(.serverError))
                    return
                }

                guard let data else {
                    completion(.failure(.invalidResponse))
                    return
                }

                do {
                    let response = try JSONDecoder().decode(ProductResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
}

