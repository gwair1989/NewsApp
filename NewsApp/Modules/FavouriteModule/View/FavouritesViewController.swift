//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 04.11.2022.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    private let favouritesView = FavouritesView()
    
    private var presenter: FavouritesViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = favouritesView
        title = "Favourites"
        presenter = FavouritesPresenter(view: self)
        bind()
        favouritesView.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getNews()
    }
    
    private func bind() {
        favouritesView.didClickReadButton = { [weak self] urlString in
            guard let self else { return }
            guard let url = URL(string: urlString) else { return }
            let vc = DatailViewController(url: url)
            self.navigationController?.pushViewController(vc, animated: true)
            self.presenter.tapOnTheDetail(urlSring: urlString)
        }

        favouritesView.didClickAddButton = { [weak self] urlString in
            guard let self else { return }
            self.presenter.removeFromFavourite(url: urlString)
            self.presenter.getNews()
        }

    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter.getNews()
        sender.endRefreshing()
    }

    
}

extension FavouritesViewController: FavouritesViewProtocol {
    func setNews(news: [FavouriteModel]) {
        favouritesView.articles = news
        favouritesView.collectionView.reloadData()
        
    }
    
}
