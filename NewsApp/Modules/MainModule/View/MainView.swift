//
//  MainView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    var articles: [MainModel] = []
    
    var didClickReadButton: ((String) -> Void)?
    var didClickAddButton: ((FavouriteModel) -> Void)?
    
    var updateUIWithData: (() -> Void)?
    
    let categoryView = HorisontalSlideView()
    
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(categoryView)
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.refreshControl = refreshControl
        addConstraint()
    }
    
    
    private func addConstraint() {
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
