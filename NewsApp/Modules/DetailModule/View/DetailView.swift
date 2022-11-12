//
//  DetailView.swift
//  NewsApp
//
//  Created by Oleksandr Khalypa on 04.11.2022.
//

import UIKit
import WebKit

class DetailView: UIView {
    
   private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        let obj = WKWebView(frame: .zero, configuration: config)
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
        addSubview(webView )
        addConstraint()
    }
    
    func config(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    private func addConstraint() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
