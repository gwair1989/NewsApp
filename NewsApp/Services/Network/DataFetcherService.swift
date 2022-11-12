//
//  DataFetcherService.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import Foundation

protocol DataServiseProtocol {
    func fetchNews(filter: Filter, completion: @escaping (News?) -> Void)
    func fetchQuery(filter: Filter, completion: @escaping (News?) -> Void)
    func fetchSourse(filter: Filter, completion: @escaping (SourcesNews?) -> Void)
}

class DataFetcherService: DataServiseProtocol {
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }

    func fetchNews(filter: Filter, completion: @escaping (News?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(typeRequest: .main, filter: filter, response: completion)
    }
    
    func fetchSourse(filter: Filter, completion: @escaping (SourcesNews?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(typeRequest: .source, filter: filter, response: completion)
    }
    
    func fetchQuery(filter: Filter, completion: @escaping (News?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(typeRequest: .search, filter: filter, response: completion)
    }
    
}
