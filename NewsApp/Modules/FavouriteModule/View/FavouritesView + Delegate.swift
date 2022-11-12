//
//  FavouritesView + Delegate.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 06.11.2022.
//

import UIKit

extension FavouritesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.isFavourite = true
            if !articles.isEmpty {
                cell.favouriteModel = articles[indexPath.row]
                cell.didClickReadButton = { [weak self] in
                    if let url = self?.articles[indexPath.row].url {
                        self?.didClickReadButton?(url)
                    }
                }
                cell.didClickAddButton = { [weak self] in
                    if let url = self?.articles[indexPath.row].url {
                        self?.didClickAddButton?(url)
                    }
                }
            }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    
    
}
