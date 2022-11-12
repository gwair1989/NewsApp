//
//  FavouritesPresenter.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 04.11.2022.
//

import Foundation
import UIKit

protocol FavouritesViewProtocol: AnyObject {
    func setNews(news: [FavouriteModel])
}

protocol FavouritesViewPresenterProtocol: AnyObject {
    init(view: FavouritesViewProtocol, storageService: FavouriteStorageManagerProtocol)
    func getNews()
    func removeFromFavourite(url: String)
    func tapOnTheDetail(urlSring: String)
}

class FavouritesPresenter: FavouritesViewPresenterProtocol {
    

    weak var view: FavouritesViewProtocol?
    let storageService: FavouriteStorageManagerProtocol!

    
    required init(view: FavouritesViewProtocol, storageService: FavouriteStorageManagerProtocol = FavouriteStorageManager()) {
        self.view = view
        self.storageService = storageService
        getNews()
    }
    
    func getNews() {
        let storageDada = storageService.fetch()
        var favouriteModel = [FavouriteModel]()
        DispatchQueue.main.async {
            for i in storageDada {
                favouriteModel.append(FavouriteModel(source: i.source,
                                                     author: i.author,
                                                     title: i.title,
                                                     description: i.descriptionArticle,
                                                     url: i.url,
                                                     image: i.image))
                
                
            }
            
            self.view?.setNews(news: favouriteModel)
        }
    }
    
    func removeFromFavourite(url: String) {
        storageService.delete(url: url)
    }
    
    func tapOnTheDetail(urlSring: String) {
        
    }
    
}
