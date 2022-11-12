//
//  MainViewPresenter.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func setNews(news: [MainModel])
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: DataServiseProtocol, storageService: FavouriteStorageManagerProtocol)
    func getNews()
    func addToFavorite(news: FavouriteModel)
    var category: CategoryNews { get set }
    var filter: Filter { get set }
}


class MainPresenter: MainViewPresenterProtocol {

    weak var view: MainViewProtocol?
    let networkService: DataServiseProtocol!
    let storageService: FavouriteStorageManagerProtocol!
    
    var news: News!
    
    var category: CategoryNews = .all {
        didSet {
            filter.source = ""
            filter.category = category
            filter.page = 1
            results = []
            getNews()
        }
    }
    
    var results: [MainModel] = []
    
    var filterPresenterProtocol: FilterPresenterProtocol?
    
    var filter: Filter = Filter(page: 1, country: "ua", language: "", source: "", category: .all) {
        didSet {
            results = []
            getNews()
        }
    }
    
    required init(view: MainViewProtocol, networkService: DataServiseProtocol = DataFetcherService(), storageService: FavouriteStorageManagerProtocol = FavouriteStorageManager()) {
        self.view = view
        self.networkService = networkService
        self.storageService = storageService
        getNews()
    }
    
    
    func addToFavorite(news: FavouriteModel) {
        storageService.save(news: news)
        
    }
    
    func getNews() {
        networkService.fetchNews(filter: filter) { [weak self] results in
            guard let self = self else { return }
            if let results = results {
                self.news = results
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

extension MainPresenter: FilterPresenterProtocol {
    func setFilter(filter: Filter) {
        self.filter = filter
    }
}


