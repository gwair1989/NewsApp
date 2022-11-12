//
//  TextField.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 08.11.2022.
//

import UIKit

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 10
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    
    func invalidateLeftView() {
        let image =  UIImageView(image: UIImage())
        image.frame = CGRect(x: 9.5, y: 9.5, width: 31, height: 31)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftView?.addSubview(image)
        leftView?.contentMode = .scaleAspectFit
        leftViewMode = .always
    }
    
    func invalidateRightView() {
        let image =  UIImageView(image: UIImage(systemName: "chevron.down"))
        image.frame = CGRect(x: 5, y: 19, width: 20, height: 13)
        image.tintColor = .darkGray
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView?.addSubview(image)
        rightView?.contentMode = .scaleAspectFit
        rightViewMode = .always
    }
    
    func setPlaceholder(text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold) as Any
        ])
    }
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
