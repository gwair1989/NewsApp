//
//  DatailViewController.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 04.11.2022.
//

import UIKit

class DatailViewController: UIViewController {
    
    let datailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = datailView
    }
    
    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        datailView.config(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
