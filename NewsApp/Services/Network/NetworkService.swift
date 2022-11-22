//
//  NetworkService.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import Foundation

protocol Networking {
    func request(typeRequest: TypeRequest, filter: Filter, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    func request(typeRequest: TypeRequest, filter: Filter, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParaments(typeRequest: typeRequest, filter: filter)
        let url = self.url(typeRequest: typeRequest, params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        print(request)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
//                headers["Authorization"] = "apiKey 0c0fd44b3069449ea8824583372d3448"
                headers["Authorization"] = "apiKey ab2ef7b4b6cd491a971e888de5b0f81d"
//        headers["Authorization"] = "apiKey 22e4ed26c2334690aa91005e370acd47"
        return headers
    }
    
    private func prepareParaments(typeRequest: TypeRequest, filter: Filter) -> [String: String] {
        var parameters = [String: String]()
        
        switch typeRequest {
        case .main:
            if !filter.source.isEmpty {
                parameters["sources"] = filter.source
            } else {
                if filter.category != .all {
                    parameters["category"] = filter.category.rawValue
                }
                if !filter.language.isEmpty {
                    parameters["language"] = filter.language
                }
                if !filter.country.isEmpty {
                    parameters["country"] = filter.country
                }
            }
        case .source:
            if !filter.source.isEmpty {
                parameters["sources"] = filter.source
            }
            if !filter.country.isEmpty {
                parameters["country"] = filter.country
            }
            if filter.category != .all {
                parameters["category"] = filter.category.rawValue
            }
            if !filter.language.isEmpty {
                parameters["language"] = filter.language
            }
        case .search:
            parameters["q"] = filter.query
        }
        
        if filter.page != 1 {
            parameters["page"] = String(filter.page)
        }
        return parameters
    }
    
    private func url(typeRequest: TypeRequest, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        
        switch typeRequest {
        case .main:
            components.path = "/v2/top-headlines"
        case .source:
            components.path = "/v2/top-headlines/sources"
        case .search:
            components.path = "/v2/everything"
        }
        
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }

    
    private func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
