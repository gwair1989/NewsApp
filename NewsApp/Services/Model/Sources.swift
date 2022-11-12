//
//  Sources.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 09.11.2022.
//

import Foundation

// MARK: - Sources
struct SourcesNews: Codable {
    let status: String
    let sources: [Source]
}

struct Source: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}


