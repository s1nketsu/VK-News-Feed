//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.


import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Something.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    // MARK: - Parameters
    
    var presenter: NewsFeedPresentationLogic?
    var worker: NewsFeedWorker?
    
    init() {
        self.worker = NewsFeedWorker()
    }
    
    // MARK: Make request method
    
    func makeRequest(request: NewsFeed.Something.Request.RequestType) {
        
        switch request {
        case .getNewsFeed:
            worker?.getFeed(completion: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentSomething(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .getUser:
            worker?.getUser(completion: { [weak self] (user) in
                self?.presenter?.presentSomething(response: .presentUserInfo(user: user))
            })
        case .revealPostIds(let postId):
            worker?.revealPostIds(forPostId: postId, completion: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentSomething(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .getNextBatch:
            presenter?.presentSomething(response: .presentFooterLoader)
            worker?.getNextBatch(completion: { [weak self] (revealedPostIds, feedResponce) in
                self?.presenter?.presentSomething(response: .presentNewsFeed(feed: feedResponce, revealedPostIds: revealedPostIds))
            })
        }
    }
}
