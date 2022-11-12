//
//  SearchPresenter.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 12.11.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func setNews(news: [MainModel])
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, networkService: DataServiseProtocol, storageService: FavouriteStorageManagerProtocol)
    func getNews()
    func addToFavorite(news: FavouriteModel)
    var filter: Filter { get set }
    var query: String { get set }
}

class SearchPresenter: SearchViewPresenterProtocol {

    weak var view: SearchViewProtocol?
    let networkService: DataServiseProtocol!
    let storageService: FavouriteStorageManagerProtocol!
    
    var results: [MainModel] = []
    
    var filterPresenterProtocol: FilterPresenterProtocol?
    
    var query: String = "" {
        didSet {
            filter.query = query
            getNews()
        }
    }
    
    var filter: Filter = Filter(page: 1, country: "ua", language: "", source: "", category: .all)
    
    required init(view: SearchViewProtocol, networkService: DataServiseProtocol = DataFetcherService(), storageService: FavouriteStorageManagerProtocol = FavouriteStorageManager()) {
        self.view = view
        self.networkService = networkService
        self.storageService = storageService
        getNews()
    }
    
    
    func addToFavorite(news: FavouriteModel) {
        storageService.save(news: news)
        
    }
    
    func getNews() {
        networkService.fetchQuery(filter: filter) { [weak self] results in
            guard let self = self else { return }
            if let results = results {
                if self.results.count < results.totalResults  {
                    DispatchQueue.main.async {
                        for i in results.articles {
                            if let urlImage = i.urlToImage, !urlImage.contains("assets"), urlImage.contains("https") {
                                let mainModel = MainModel(source: i.source.name,
                                                          author: i.author,
                                                          title: i.title,
                                                          description: i.description,
                                                          url: i.url,
                                                          urlToImage: urlImage)
                                
                                self.results.append(mainModel)
                            }
                        }
                        self.view?.setNews(news: self.results)
                    }
                }
            }
        }
    }
    
    
    
    
}
