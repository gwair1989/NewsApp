//
//  Model.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: NewsSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}

// MARK: - Source
struct NewsSource: Codable {
    let name: String
}
