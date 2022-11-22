//
//  SearchView + Delegates.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 12.11.2022.
//

import UIKit

extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        if !dataArray.isEmpty {
            cell.mainModel = dataArray[indexPath.row]
            cell.isFavourite = false
            cell.didClickButton = { [weak self] pressedButton in
                switch pressedButton {
                case .read:
                    if let url = self?.dataArray[indexPath.row].url {
                        self?.didClickReadButton?(url)
                    }
                case .add:
                    if let article = self?.dataArray[indexPath.row] {
                        self?.didClickAddButton?(FavouriteModel(source: article.source,
                                                                author: article.author,
                                                                title: article.title,
                                                                description: article.description,
                                                                url: article.url,
                                                                image: cell.newsImage.image?.pngData()))
                    }
                case .share:
                    if let url = self?.dataArray[indexPath.row].url {
                        self?.didClickShareButton?(url)
                    }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
    }
}


extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        didSearchQuery?(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        dataArray = []
        didSearchQuery?(nil)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
