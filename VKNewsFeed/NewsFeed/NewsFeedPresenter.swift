//
//  NewsFeedPresenter.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.

import UIKit
import Foundation

protocol NewsFeedPresentationLogic {
    func presentSomething(response: NewsFeed.Something.Response.ResponceType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    // MARK: - Parameters
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM 'в' HH:mm"
        return dateFormatter
    }()
    
    // MARK: Methods
    
    func presentSomething(response: NewsFeed.Something.Response.ResponceType) {
        
        switch response {
        case .presentNewsFeed(let feed, let revealedPostIds):
            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
            }
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("Newsfeed Cells Count", comment: ""), cells.count)
            let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
            viewController?.displaySomething(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
            
        case .presentUserInfo(user: let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displaySomething(viewModel: .displayUserInfo(userViewModel: userViewModel))
            
        case .presentFooterLoader:
            viewController?.displaySomething(viewModel: .displayFooterLoader)
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let date = Date(timeIntervalSince1970: TimeInterval(feedItem.date))
        let dateTitle = dateFormatter.string(from: date)
        let isFullSized = revealedPostIds.contains { postId -> Bool in
            return postId == feedItem.postId
        }
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formatterCounter(feedItem.likes?.count),
                                       comments: formatterCounter(feedItem.comments?.count),
                                       shares: formatterCounter(feedItem.reposts?.count),
                                       views: formatterCounter(feedItem.views?.count),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    
    private func formatterCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "К"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "М"
        }
        return counterString
    }
    
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = sourseId >= 0 ? profiles : groups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourseId
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoURL: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoURL: photo.srcBIG,
                                                              width: photo.width,
                                                              height: photo.height)
        }
    }
}

