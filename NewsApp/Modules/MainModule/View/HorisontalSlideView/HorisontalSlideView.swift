//
//  HorisontalSlideView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 08.11.2022.
//

import UIKit

protocol SelectHorisontalSlideViewItem: AnyObject {
    func selectItem(category: CategoryNews)
}


class HorisontalSlideView: UICollectionView {
    
    weak var cellDelegate: SelectHorisontalSlideViewItem?
    
    private let layout = UICollectionViewFlowLayout()
    
    let sectionInserts = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: self.layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        bounces = false
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
        register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionViewDataSource

extension HorisontalSlideView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryNews.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.label.text = CategoryNews.allCases[indexPath.item].rawValue.capitalized
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension HorisontalSlideView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(category: CategoryNews.allCases[indexPath.item])
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HorisontalSlideView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font: UIFont = .systemFont(ofSize: 12, weight: .semibold)
        let attributes = [NSAttributedString.Key.font : font as Any]
        let cellWidth = CategoryNews.allCases[indexPath.item].rawValue.capitalized.size(withAttributes: attributes).width + 16
        
        
        return CGSize(width: cellWidth, height: collectionView.frame.height - 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
}
