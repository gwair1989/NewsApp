//
//  FilterPresenter.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 08.11.2022.
//

import Foundation

protocol FilterViewControllerProtocol: AnyObject {
    init(view: FilterViewPresenterProtocol, networkService: DataServiseProtocol)
    func getSourses()
    func setFilter()
    var category: CategoryNews { get set }
    var country: String { get set }
    var language: String { get set }
    var source: String { get set }
    var filter: Filter { get set }
}

protocol FilterViewPresenterProtocol: AnyObject {
    func setFilter(filter: FilterModel)
}

class FilterPresenter: FilterViewControllerProtocol {
    
    weak var view: FilterViewPresenterProtocol?
    let networkService: DataServiseProtocol!
    
    var category: CategoryNews = .all {
        didSet {
            setFilter()
            getSourses()
        }
    }
    var country = "" {
        didSet {
            setFilter()
            getSourses()
        }
    }
    var language = "" {
        didSet {
            setFilter()
            getSourses()
        }
    }
    
    var source = "" {
        didSet {
            setFilter()
        }
    }
    
    var filter = Filter(page: 1, country: "", language: "", source: "", category: .all)
    
    required init(view: FilterViewPresenterProtocol, networkService: DataServiseProtocol = DataFetcherService()) {
        self.view = view
        self.networkService = networkService
        getSourses()
    }

    func getSourses() {
        print(filter)
        networkService.fetchSourse(filter: filter) { [weak self] results in
            guard let self, let results else { return }
            DispatchQueue.main.async {
                self.view?.setFilter(filter: FilterModel(countries: self.getСountries(),
                                                    languages: self.getLanguages(),
                                                    sources: results.sources))
            }
        }
    }
    func setFilter() {
            filter = Filter(page: 1, country: self.country,
                            language: self.language,
                            source: self.source,
                            category: self.category)
    }
    
    private func getСountries() -> [Country] {
        var countries = [Country(flag: "", country: "All", code: "")]
        for code in CountryNews.allCases {
            let country = getCountry(code: code.rawValue)
            countries.append(country)
        }
        return countries
    }
    
    private func getLanguages() -> [Language] {
        var languages = [Language(language: "All", code: "")]
        for lang in LanguageNews.allCases {
            let language = getLanguage(code: lang.rawValue)
            languages.append(language)
        }
        return languages
    }
    
    
    
    private func getLanguage(code: String) -> Language {
        let languages = getAllLanguages()
        if let language = languages.first(where: { $0.code == code }) {
            return Language(language: language.language, code: code)
        }
        return Language(language: "", code: "")
    }
    
    private func getAllLanguages() -> [Language] {
        let languages: [Language] = NSLocale.isoLanguageCodes.map {
            let language = (Locale.current as NSLocale).displayName(forKey: .languageCode, value: $0)
            return Language(language: language ?? "", code: $0)
        }
        return languages
    }
    
    
    private func getCountry(code: String) -> Country {
        let currentCode = code.uppercased()
        let countries: [Country] = NSLocale.isoCountryCodes.map {
            let country = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: $0)
            return Country(flag: getFlag(from: currentCode), country: country ?? "", code: $0)
        }
        
        if let country = countries.first(where: { $0.code == currentCode }) {
            return country
        }
        return Country(flag: "", country: "", code: "")
    }
    
    private func getFlag(from countryCode: String) -> String {
        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }

    
    
}


