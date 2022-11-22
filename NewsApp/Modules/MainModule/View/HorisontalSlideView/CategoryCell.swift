//
//  CategoryCell.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 08.11.2022.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    let label: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .center
        obj.textColor = .black
        obj.font = .systemFont(ofSize: 12, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? .lightGray : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(label)
        backgroundColor = .none
        layer.cornerRadius = 10
        
        addConstraints()
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
