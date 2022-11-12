//
//  FavouriteCoreDataManager.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import Foundation
import CoreData

protocol FavouriteStorageManagerProtocol {
    func fetch() -> [SavedArticle]
    func delete(url: String)
    func save(news: FavouriteModel)
}


class FavouriteStorageManager: FavouriteStorageManagerProtocol {
    func fetch() -> [SavedArticle] {
        let request = SavedArticle.fetchRequest()
        let savedArticle = CoreDataManager.shared.fetch(request: request)
        return savedArticle
    }

    func delete(url: String) {
        let request = SavedArticle.fetchRequest(url: url)
        CoreDataManager.shared.delete(request: request)
    }

    func save(news: FavouriteModel) {
        let favouriteNews = fetch()
        guard favouriteNews.contains(where: { $0.url == news.url }) == false else { return }

        let context = CoreDataManager.shared.context
        guard let description = NSEntityDescription.entity(
            forEntityName: "SavedArticle",
            in: context
        ) else { return }

        let newsObject = SavedArticle(entity: description, insertInto: context)
        newsObject.url = news.url
        newsObject.title = news.title
        newsObject.image = news.image
        newsObject.source = news.source
        newsObject.author = news.author
        newsObject.descriptionArticle = news.description

        CoreDataManager.shared.saveContext()
    }
}
