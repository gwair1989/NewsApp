//
//  MainView + Delegate.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import UIKit

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
            if !articles.isEmpty {
                cell.mainModel = articles[indexPath.row]
                cell.isFavourite = false
                cell.didClickReadButton = { [weak self] in
                    if let url = self?.articles[indexPath.row].url {
                        self?.didClickReadButton?(url)
                    }
                }
                cell.didClickAddButton = { [weak self] in
                    if let article = self?.articles[indexPath.row] {
                        self?.didClickAddButton?(FavouriteModel(source: article.source,
                                                                author: article.author,
                                                                title: article.title,
                                                                description: article.description,
                                                                url: article.url,
                                                                image: cell.newsImage.image?.pngData()))
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
        return .init(top: 0, left: sectionInserts.left, bottom: sectionInserts.bottom, right: sectionInserts.right)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let heightCard = collectionView.frame.width
        
        if offsetY > contentHeight - scrollView.frame.size.height - heightCard {
            self.updateUIWithData?()
        }
    }

    
    
}
