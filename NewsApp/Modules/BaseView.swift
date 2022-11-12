//
//  BaseView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 06.11.2022.
//

import UIKit

class BaseView: UIView {
    let itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 24
        flowLayout.minimumInteritemSpacing = 8
        let obj = UICollectionView(frame: .zero,
                                   collectionViewLayout: flowLayout)
        obj.contentInsetAdjustmentBehavior = .automatic
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .white
        obj.allowsMultipleSelection = true
        obj.showsHorizontalScrollIndicator = false
        return obj
    }()
    
    let refreshControl: UIRefreshControl = {
        let obj = UIRefreshControl()
        return obj
    }()
    
    
}
