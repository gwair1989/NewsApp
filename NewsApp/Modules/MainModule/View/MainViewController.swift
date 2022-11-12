//
//  ViewController.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData()
        setupNavBar()
    }
    
    private func setup() {
        presenter = MainPresenter(view: self)
        title = "My news"
        bind()
        mainView.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        mainView.categoryView.cellDelegate = self
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
        
        mainView.updateUIWithData = { [weak self] in
            guard let self else { return }
            self.presenter.filter.page += 1
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter.getNews()
        sender.endRefreshing()
    }
    
    private func setupNavBar() {
        let image = UIImage(systemName: "list.bullet")
        let filterButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tapFilterButton))
        filterButton.tintColor = .black
        navigationItem.leftBarButtonItem = filterButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func tapFilterButton() {
        let vc = FilterViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    
}

extension MainViewController: MainViewProtocol {
    func setNews(news: [MainModel]) {
        mainView.articles = news
        mainView.collectionView.reloadData()
    }
    

}

extension MainViewController: SelectHorisontalSlideViewItem {
    func selectItem(category: CategoryNews) {
        presenter.category = category
        mainView.collectionView.scrollToItem(at: [0,0], at: [], animated: true)
    }
}

extension MainViewController: FilterPresenterProtocol {
    func setFilter(filter: Filter) {
        self.presenter.filter = filter
    }
}
