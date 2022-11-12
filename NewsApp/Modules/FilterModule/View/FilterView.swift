//
//  FilterView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 07.11.2022.
//

import UIKit
import SnapKit

class FilterView: UIView {
    
    var filter: FilterModel? {
        didSet {
            tableView.reloadData()
            countryPickerView.reloadAllComponents()
            languagePickerView.reloadAllComponents()
        }
    }
    var selectedIndex: IndexPath?
    
    var didSelectedCountry: ((String) -> Void)?
    var didSelectedLanguage: ((String) -> Void)?
    var didSelectedCategory: ((CategoryNews) -> Void)?
    var didSelectedSourse: ((String) -> Void)?
    
    let sectionInserts = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    let stackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .horizontal
        obj.distribution = .fillEqually
        obj.spacing = 8
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let categoryTextField: TextFieldWithPadding = {
        let obj = TextFieldWithPadding()
        obj.placeholder = "Category"
        obj.placeHolderColor = .lightGray
        obj.backgroundColor = .white
        obj.textContentType = .name
        obj.textColor = .black
        obj.layer.cornerRadius = 12
        obj.clipsToBounds = true
        obj.returnKeyType = .done
        obj.layer.borderWidth = 1
        obj.layer.borderColor = UIColor.lightGray.cgColor
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let countryTextField: TextFieldWithPadding = {
        let obj = TextFieldWithPadding()
        obj.placeholder = "Country"
        obj.placeHolderColor = .lightGray
        obj.backgroundColor = .white
        obj.textContentType = .name
        obj.textColor = .black
        obj.layer.cornerRadius = 12
        obj.clipsToBounds = true
        obj.returnKeyType = .done
        obj.layer.borderWidth = 1
        obj.layer.borderColor = UIColor.lightGray.cgColor
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let languageTextField: TextFieldWithPadding = {
        let obj = TextFieldWithPadding()
        obj.placeholder = "Language"
        obj.placeHolderColor = .lightGray
        obj.backgroundColor = .white
        obj.textContentType = .name
        obj.textColor = .black
        obj.layer.cornerRadius = 12
        obj.clipsToBounds = true
        obj.returnKeyType = .done
        obj.layer.borderWidth = 1
        obj.layer.borderColor = UIColor.lightGray.cgColor
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let countryPickerView: UIPickerView = {
        let obj = UIPickerView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let languagePickerView: UIPickerView = {
        let obj = UIPickerView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let categoryPickerView: UIPickerView = {
        let obj = UIPickerView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .plain)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .white
        obj.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(countryTextField)
        stackView.addArrangedSubview(languageTextField)
        stackView.addArrangedSubview(categoryTextField)

        self.countryTextField.delegate = self
        self.countryPickerView.delegate = self
        self.countryPickerView.dataSource = self
        
        self.languageTextField.delegate = self
        self.languagePickerView.delegate = self
        self.languagePickerView.dataSource = self
        
        self.categoryTextField.delegate = self
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        
        languageTextField.inputView = languagePickerView
        countryTextField.inputView = countryPickerView
        categoryTextField.inputView = categoryPickerView
//        countryTextField.invalidateLeftView()
//        countryTextField.invalidateRightView()
        
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SourceCell.self, forCellReuseIdentifier: SourceCell.identifier)
        addConstraint()
        dismissPickerView()
    }
    
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        countryTextField.inputAccessoryView = toolBar
        languageTextField.inputAccessoryView = toolBar
        categoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        self.endEditing(true)
    }
    
    private func addConstraint() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(sectionInserts.top)
            make.leading.equalToSuperview().offset(sectionInserts.left)
            make.trailing.equalToSuperview().offset(-sectionInserts.right)
            make.height.equalTo(42)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.equalToSuperview().offset(sectionInserts.left)
            make.trailing.equalToSuperview().offset(-sectionInserts.right)
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}

extension FilterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



