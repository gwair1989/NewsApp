//
//  SearchView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 12.11.2022.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    var dataArray: [MainModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didClickReadButton: ((String) -> Void)?
    var didClickAddButton: ((FavouriteModel) -> Void)?
    var didClickShareButton: ((String) -> Void)?
    var didSearchQuery: ((String?) -> Void)?
    
    let searchBar: UISearchBar = {
        let obj = UISearchBar()
        obj.backgroundImage = UIImage()
        obj.placeholder = "Search"
        obj.searchTextField.textColor = .black
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(collectionView)
        
        addSubview(searchBar)
        searchBar.delegate = self
        searchBar.searchTextField.leftView?.tintColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.refreshControl = refreshControl
        addConstraint()
    }
    
    private func addConstraint() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
