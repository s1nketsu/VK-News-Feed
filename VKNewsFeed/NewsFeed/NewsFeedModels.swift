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
            }
        }
        struct Response {
            enum ResponceType {
                case presentNewsFeed(feed: FeedResponce)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoURL: String?
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
