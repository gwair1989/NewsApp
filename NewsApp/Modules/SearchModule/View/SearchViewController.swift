//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 12.11.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let mainView = SearchView()
    private var timer: Timer?
    var presenter: SearchViewPresenterProtocol!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        title = "Search"
        bind()
    }
    
    private func bind() {
        mainView.didClickReadButton = { [weak self] urlString in
            guard let self else { return }
            guard let url = URL(string: urlString) else { return }
            let vc = DatailViewController(url: url)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        mainView.didClickAddButton = { [weak self] article in
            guard let self else { return }
            self.presenter.addToFavorite(news: article)
        }
        
        mainView.didSearchQuery = { [weak self] query in
            guard let self, let query else { return }
            if self.timer != nil {
                self.timer?.invalidate()
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.presenter.query = query
            })
        }
    }
}

extension SearchViewController: SearchViewProtocol {
    func setNews(news: [MainModel]) {
        mainView.dataArray = news
    }

}
