//
//  FilterView + UIPickerViewDelegate.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 09.11.2022.
//

import UIKit

extension FilterView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let filter {
            if pickerView == countryPickerView {
                return filter.countries.count
            }
            if pickerView == languagePickerView {
                return filter.languages.count
            }
        }

        if pickerView == categoryPickerView {
            return CategoryNews.allCases.count
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let filter {
            
            if pickerView == countryPickerView {
                return "\(filter.countries[row].flag) \(String(describing: filter.countries[row].country))"
            }
            
            if pickerView == languagePickerView {
                return filter.languages[row].language
            }
            
        }
        if pickerView == categoryPickerView {
            return CategoryNews.allCases[row].rawValue.capitalized
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let filter {
            if pickerView == countryPickerView {
                self.countryTextField.text = filter.countries[row].country
                didSelectedCountry?(filter.countries[row].code)
            }
            
            if pickerView == languagePickerView {
                self.languageTextField.text = filter.languages[row].language
                didSelectedLanguage?(filter.languages[row].code)
            }
        }
        
        if pickerView == categoryPickerView {
            self.categoryTextField.text = CategoryNews.allCases[row].rawValue.capitalized
            didSelectedCategory?(CategoryNews.allCases[row])
        }
    }
}
