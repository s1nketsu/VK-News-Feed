//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 18.01.2023.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var showMoreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol NewsFeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class NewsFeedCellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat = min(SceneDelegate.shared().window!.screen.bounds.width,
                                    SceneDelegate.shared().window!.screen.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButtonAppearance = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: - postLabelFrame configuration
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButtonAppearance = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: - showMoreTextButtonFrame configuration
        
        var showMoreTextButtonSize = CGSize.zero
        if showMoreTextButtonAppearance {
            showMoreTextButtonSize = Constants.showMoreTextButtonSize
        }
        let showMoreTextButtonOrigin = CGPoint(x: Constants.showMoreTextButtonInsets.left, y: postLabelFrame.maxY)
        let showMoreTextButtonFrame = CGRect(origin: showMoreTextButtonOrigin, size: showMoreTextButtonSize)
        
        // MARK: - attachmentFrame configuration
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : showMoreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: attachmentTop),
                                     size: CGSize.zero)
        
        if let attachment = photoAttachments.first {
            let ratio: CGFloat = CGFloat(Float(attachment.height) / Float(attachment.width))
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth,
                                                          height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
        }
        
        // MARK: - bottomViewFrame configuration
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth,
                                                  height: Constants.bottomViewHeight))
        
        // MARK: - totalHeight configuration
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        
        return Sizes(postLabelFrame: postLabelFrame,
                     showMoreTextButtonFrame: showMoreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}
