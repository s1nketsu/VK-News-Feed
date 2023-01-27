//
//  FooterView.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 27.01.2023.
//

import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.6919150949, green: 0.7063220143, blue: 0.7199969292, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myLabel)
        addSubview(loader)
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            myLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8)
        ])
        loader.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        loader.stopAnimating()
        myLabel.text = title
    }
}
