//
//  TitleView.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 25.01.2023.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var myTextField = InsertableTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTextField)
        addSubview(myAvatarView)
        setConstraints()
    }
    
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            myAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            myAvatarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1),
            myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1),
        
            myTextField.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            myTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            myTextField.trailingAnchor.constraint(equalTo: myAvatarView.leadingAnchor, constant: -12),
            myTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
