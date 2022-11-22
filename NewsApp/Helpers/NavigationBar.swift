//
//  NavigationBar.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 22.11.2022.
//

import UIKit

extension UINavigationController {
    func setTitleColor(color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
}



