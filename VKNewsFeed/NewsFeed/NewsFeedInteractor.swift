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
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    // MARK: Do something
    
    func makeRequest(request: NewsFeed.Something.Request.RequestType) {
        worker = NewsFeedWorker()
        worker?.doSomeWork()
        
        switch request {
            
        case .getNewsFeed:
            fetcher.getFeed { [weak self] feedResponce in
                guard let feedResponce = feedResponce else { return }
                self?.presenter?.presentSomething(response: .presentNewsFeed(feed: feedResponce))
            }
        }
    }
}
