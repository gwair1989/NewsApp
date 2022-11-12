//
//  FilterView + UITableViewDelegate.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 09.11.2022.
//

import UIKit

extension FilterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sourcesCount = filter?.sources.count {
            return sourcesCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SourceCell.identifier, for: indexPath) as! SourceCell
        if let source = filter?.sources[indexPath.row] {
            cell.source = source
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countryTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
        languageTextField.resignFirstResponder()
        
        if let selectedIndex, indexPath != selectedIndex {
            if let cell = tableView.cellForRow(at: selectedIndex) {
                cell.accessoryType = .none
            }
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                selectedIndex = indexPath
                if let source = filter?.sources[indexPath.row].id {
                    didSelectedSourse?(source)
                }
            } else {
                cell.accessoryType = .none
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
