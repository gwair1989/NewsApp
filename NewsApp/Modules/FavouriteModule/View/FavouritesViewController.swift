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
        navigationController?.setTitleColor(color: .black)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getNews()
    }
    
    private func bind() {

        favouritesView.didClickButton = { [weak self] pressedButton, urlString in
            guard let self, let url = URL(string: urlString) else { return }
            switch pressedButton {
            case .read:
                let vc = DatailViewController(url: url)
                self.navigationController?.pushViewController(vc, animated: true)
                self.presenter.tapOnTheDetail(urlSring: urlString)
            case .add:
                self.presenter.removeFromFavourite(url: urlString)
                self.presenter.getNews()
            case .share:
                let shareController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                shareController.popoverPresentationController?.permittedArrowDirections = .any
                self.present(shareController, animated: true, completion: nil)
            }
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
