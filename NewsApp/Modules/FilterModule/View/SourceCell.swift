//
//  SourceCell.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 07.11.2022.
//

import UIKit
import SnapKit

final class SourceCell: UITableViewCell {
    
    static let identifier = "SourceCell"
    
    var source: Source! {
        didSet {
            nameLabel.text = source.name
            descriptionLabel.text = source.description
            self.layoutIfNeeded()
        }
    }
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.font = .systemFont(ofSize: 16, weight: .bold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 14, weight: .bold)
        obj.numberOfLines = 0
        obj.textColor = .darkGray
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addConstraint()
    }
    
    private func addConstraint() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-4)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(-8)
        }
        
    }
}
