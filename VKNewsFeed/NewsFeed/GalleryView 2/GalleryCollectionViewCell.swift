//
//  GalleryCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 21.01.2023.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        backgroundColor = .cyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageURL: String?) {
        myImageView.set(imageURL: imageURL)
    }
}
