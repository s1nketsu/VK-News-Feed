//
//  NewsFeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 19.01.2023.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get set }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var showMoreTextButtonFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoURL: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol NewsFeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseID = "NewsFeedCodeCell"
    
    weak var delegate: NewsFeedCodeCellDelegate?
    
    //Первый слой
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Второй слой
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let postLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = Constants.postLabelFont
//        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1803921569, alpha: 1)
//        return label
//    }()
    
    let postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        textView.backgroundColor = .white
        textView.textColor = .black
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return textView
    }()
    
    let showMoreTextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Показать полностью...", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        button.setTitleColor(#colorLiteral(red: 0.4691888094, green: 0.6887934804, blue: 0.8642576933, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
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
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
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
        showMoreTextButton.addTarget(self, action: #selector(showMoreTextButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showMoreTextButtonTapped() {
        delegate?.revealPost(for: self)
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
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        showMoreTextButton.frame = viewModel.sizes.showMoreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoURL)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    private func overlayFirstLayer() {
        self.contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(showMoreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        NSLayoutConstraint.activate([
            
            //topView contraints
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
            
            //likesView contraints
            likesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            likesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth),
            
            //commentsView contraints
            commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor),
            commentsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth),
            
            //sharesView contraints
            sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor),
            sharesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight),
            sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth),
            
            //viewsView contraints
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
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewImageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewImageSize),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}
