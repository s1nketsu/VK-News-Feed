//
//  NewsFeedModels.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.


import UIKit

enum NewsFeed {
    
    enum Something {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case getUser
                case revealPostIds(postId: Int)
                case getNextBatch
            }
        }
        struct Response {
            enum ResponceType {
                case presentNewsFeed(feed: FeedResponce, revealedPostIds: [Int])
                case presentUserInfo(user: UserResponce?)
                case presentFooterLoader
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
                case displayUserInfo(userViewModel: UserViewModel)
                case displayFooterLoader
            }
        }
    }
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoURL: String?
        var width: Int
        var height: Int
    }
    let cells: [Cell]
    let footerTitle: String?
}

