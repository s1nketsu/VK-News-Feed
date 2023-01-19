//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 18.01.2023.
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
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomView: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoURL: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseID = "NewsFeedCell"
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImage: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage?.layer.cornerRadius = iconImage.frame.width / 2
        iconImage?.clipsToBounds = true
        
        cardView?.layer.cornerRadius = 10
        cardView?.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImage.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        postImageView.frame = viewModel.sizes.attachmentFrame
//        bottomView.frame = viewModel.sizes.bottomView
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoURL)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}