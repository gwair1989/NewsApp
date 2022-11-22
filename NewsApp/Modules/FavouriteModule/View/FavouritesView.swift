//
//  FavouritesView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 06.11.2022.
//

import UIKit
import SnapKit

class FavouritesView: BaseView {

    var articles: [FavouriteModel] = []
    
//    var didClickReadButton: ((String) -> Void)?
//    var didClickAddButton: ((String) -> Void)?
//    var didClickShareButton: ((String) -> Void)?
//    
    var didClickButton: ((CellButtonTap, String) -> Void)?
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(collectionView)
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.refreshControl = refreshControl
        addConstraint()
    }
    
    
    private func addConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
