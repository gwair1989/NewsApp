//
//  Filter.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 10.11.2022.
//

import Foundation

struct Filter {
    var page: Int
    let country: String
    let language: String
    var source: String
    var category: CategoryNews
    var query: String?
}
