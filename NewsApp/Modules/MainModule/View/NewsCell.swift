//
//  NewsCell.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 02.11.2022.
//

import UIKit
import SDWebImage

class NewsCell: UICollectionViewCell {
    
    static let identifier = "NewsCell"
    
    var didClickReadButton: (() -> Void)?
    var didClickAddButton: (() -> Void)?
    
    var isFavourite = false {
        didSet {
            addButton.tintColor = self.isFavourite ? .black : .lightGray
        }
    }
    
    var mainModel: MainModel! {
        didSet {
            if let author = mainModel.author {
                authorLabel.isHidden = false
                authorLabel.text = author
            } else { authorLabel.isHidden = true }
            
            sourceLabel.text = mainModel.source
            titleLabel.text = mainModel.title
            
            if let description = mainModel.description {
                descriptionLabel.isHidden = false
                descriptionLabel.text = description
            } else { descriptionLabel.isHidden = true }
            
            self.layoutIfNeeded()
            guard let imageUrl = mainModel.urlToImage, let url = URL(string: imageUrl) else { return }
            
            UIView.transition(
                with: newsImage,
                duration: 0.2,
                options: [.transitionCrossDissolve],
                animations: { [weak self] in
                    self?.newsImage.sd_setImage(with: url)
                },
                completion: nil
            )
        }
    }
    
    var favouriteModel: FavouriteModel! {
        didSet {
            if let author = favouriteModel.author {
                authorLabel.isHidden = false
                authorLabel.text = author
            } else { authorLabel.isHidden = true }
            
            sourceLabel.text = favouriteModel.source
            titleLabel.text = favouriteModel.title
            
            if let description = favouriteModel.description {
                descriptionLabel.isHidden = false
                descriptionLabel.text = description
            } else { descriptionLabel.isHidden = true }
            
            self.layoutIfNeeded()
            guard let imageData = favouriteModel.image,
                  let image = UIImage(data: imageData) else { return }
            
            UIView.transition(
                with: newsImage,
                duration: 0.2,
                options: [.transitionCrossDissolve],
                animations: { [weak self] in
                    self?.newsImage.image = image
                },
                completion: nil
            )
        }
    }
    
    let newsImage: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 9
        obj.clipsToBounds = true
        obj.backgroundColor = .lightGray
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let authorLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 10, weight: .semibold)
        obj.textColor = UIColor(red: 0.231, green: 0.537, blue: 0.541, alpha: 1)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let sourceLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 9, weight: .semibold)
        obj.textColor = UIColor(red: 0.231, green: 0.537, blue: 0.541, alpha: 1)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    //    private let categoryLabel: UILabel = {
    //        let obj = UILabel()
    //        obj.text = "Политика"
    //        obj.font = .systemFont(ofSize: 10, weight: .semibold)
    //        obj.textColor = UIColor(red: 0.231, green: 0.537, blue: 0.541, alpha: 1)
    //        obj.translatesAutoresizingMaskIntoConstraints = false
    //        return obj
    //    }()
    
    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 16, weight: .bold)
        obj.textColor = .black
        obj.numberOfLines = 2
        obj.lineBreakMode = .byWordWrapping
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 14, weight: .bold)
        obj.textColor = .darkGray
        obj.numberOfLines = 4
        obj.lineBreakMode = .byWordWrapping
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var addButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setImage(UIImage(systemName: "bookmark.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        obj.imageView?.contentMode = .scaleAspectFit
        obj.tintColor = .lightGray
        obj.addAction(UIAction { [weak self]  _ in
            guard let self else { return }
            self.isFavourite = !self.isFavourite
            self.didClickAddButton?()
        }, for: .touchUpInside)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var readButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.layer.borderWidth = 1
        obj.layer.borderColor = UIColor.lightGray.cgColor
        obj.setTitle("Read", for: .normal)
        obj.setTitleColor(UIColor(red: 0.231, green: 0.537, blue: 0.541, alpha: 1), for: .normal)
        obj.addAction(UIAction { [weak self]  _ in
            guard let self else { return }
            self.didClickReadButton?()
        }, for: .touchUpInside)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var shareButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setImage(UIImage(systemName: "square.and.arrow.up")?
            .withRenderingMode(.alwaysTemplate), for: .normal)
        obj.imageView?.contentMode = .scaleAspectFit
        obj.tintColor = .lightGray
        obj.addAction(UIAction { [weak self]  _ in
            guard let self else { return }
            obj.tintColor = .black
        }, for: .touchUpInside)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let bottomStackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .horizontal
        obj.distribution = .fill
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
    }
    
    
    private func setupUI() {
        contentView.addSubview(newsImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(sourceLabel)
        //        contentView.addSubview(categoryLabel)
        contentView.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(addButton)
        bottomStackView.addArrangedSubview(shareButton)
        bottomStackView.addArrangedSubview(readButton)
        
        addConstraint()
    }
    
    private func addConstraint() {
        
        newsImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        //        categoryLabel.snp.makeConstraints { make in
        //            make.top.equalTo(newsImage.snp.bottom).offset(4)
        //            make.height.equalTo(20)
        //            make.leading.equalToSuperview()
        //            make.trailing.equalToSuperview()
        //        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(shareButton.snp.width).multipliedBy(1)
        }
        readButton.snp.makeConstraints { make in
            make.width.equalTo(shareButton.snp.width).multipliedBy(2)
        }
        
    }
    
}
