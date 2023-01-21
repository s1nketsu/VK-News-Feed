//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.


import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Something.Request.RequestType)
}

protocol NewsFeedDataStore {
    //var name: String { get set }
}

class NewsFeedInteractor: NewsFeedBusinessLogic, NewsFeedDataStore {
    
    var presenter: NewsFeedPresentationLogic?
    var worker: NewsFeedWorker?
    private var revealedPostIds = [Int]()
    private var feedResponce: FeedResponce?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    // MARK: Do something
    
    func makeRequest(request: NewsFeed.Something.Request.RequestType) {
        worker = NewsFeedWorker()
        worker?.doSomeWork()
        
        switch request {
            
        case .getNewsFeed:
            fetcher.getFeed { [weak self] feedResponce in
                self?.feedResponce = feedResponce
                self?.presentFeed()
            }
        case .revealPostIds(postId: let postId):
            revealedPostIds.append(postId)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponce = feedResponce else { return }
        presenter?.presentSomething(response: .presentNewsFeed(feed: feedResponce, revealedPostIds: revealedPostIds))
    }
}
