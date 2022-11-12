//
//  FilterModel.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 10.11.2022.
//

import Foundation

struct FilterModel {
    let countries: [Country]
    let languages: [Language]
    let sources: [Source]
}

struct Country {
    let flag: String
    let country: String
    let code: String
}

struct Language {
    let language: String
    let code: String
}

enum LanguageNews: String, CaseIterable {
    case ar, de, en, es, fr, he, it, nl, no, pt, ru, uk, sv, zh
}

enum CategoryNews: String, CaseIterable {
    case all
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

enum CountryNews: String, CaseIterable {
    case ae
    case ar
    case at
    case au
    case be
    case bg
    case br
    case ca
    case ch
    case cn
    case co
    case cu
    case cz
    case de
    case eg
    case fr
    case gb
    case gr
    case hk
    case hu
    case id
    case ie
    case il
    case it
    case jp
    case kr
    case lt
    case lv
    case ma
    case mx
    case my
    case ng
    case nl
    case no
    case nz
    case ph
    case pl
    case pt
    case ro
    case rs
    case ru
    case sa
    case se
    case sg
    case si
    case sk
    case th
    case tr
    case tw
    case ua
    case us
    case ve
    case za
}
