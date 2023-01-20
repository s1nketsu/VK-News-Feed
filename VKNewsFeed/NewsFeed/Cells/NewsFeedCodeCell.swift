//
//  NewsFeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 19.01.2023.
//

import UIKit

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseID = "NewsFeedCodeCell"
    
    //Первый слой
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Второй слой
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
        return label
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Третий слой topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.layer.cornerRadius = Constants.topViewHeight / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Третий слой bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Четвертый слой bottomVie
    
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "like")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "comment")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "share")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "eye")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(cardView)
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        overlayFirstLayer() // Первый слой
        overlaySecondLayer() // Второй слой
        overlayThirdLayerTopView() // Третий слой topView
        overlayThirdLayerBottomView() // Третий слой bottomView
        overlayFourthLayerBottomView() // Четвертый слой bottomView
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomView
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoURL)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
        ])
    }
    
    private func overlayThirdLayerTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            //iconImageView contraints
            iconImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight),
            
            //nameLabel contraints
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 1),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2),
            
            //dateLabel contraints
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -1),
            dateLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2)])
    }
    
    private func overlayThirdLayerBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        NSLayoutConstraint.activate([
            likesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            likesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth),
            
            commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor),
            commentsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth),
            
            sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor),
            sharesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth),
            
            viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            viewsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            viewsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth)
        ])
    }
    
    private func overlayFourthLayerBottomView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewImageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewImageSize),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
