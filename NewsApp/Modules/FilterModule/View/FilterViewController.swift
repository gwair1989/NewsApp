//
//  FilterViewController.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 07.11.2022.
//

import UIKit

protocol FilterPresenterProtocol: AnyObject {
    func setFilter(filter: Filter)
}

class FilterViewController: UIViewController {
    
    var presenter: FilterViewControllerProtocol!
    weak var delegate: FilterPresenterProtocol?
    let filterView = FilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = filterView
        presenter = FilterPresenter(view: self)
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.setFilter(filter: presenter.filter)
    }
    
    private func bind() {
        filterView.didSelectedCategory = { [weak self] category in
            guard let self else { return }
            self.presenter.category = category
        }
        
        filterView.didSelectedLanguage = { [weak self] language in
            guard let self else { return }
            if language != "All" {
                self.presenter.language = language
            }
        }
        
        filterView.didSelectedCountry = { [weak self] country in
            guard let self else { return }
            if country != "All" {
                self.presenter.country = country
            }
        }
        
        filterView.didSelectedSourse = { [weak self] sourse in
            guard let self else { return }
            if !sourse.isEmpty {
                self.presenter.source = sourse
            }
        }
    }
    

}

extension FilterViewController: FilterViewPresenterProtocol {
    func setFilter(filter: FilterModel) {
        self.filterView.filter = filter
    }
    
    
}
