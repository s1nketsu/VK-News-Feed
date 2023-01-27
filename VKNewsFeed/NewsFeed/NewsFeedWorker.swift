//
//  NewsFeedWorker.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.


import UIKit

class NewsFeedWorker {
    
    // MARK: - Parameters
    
    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponce: FeedResponce?
    private var newFromInProcess: String?
    
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    // MARK: - Request methods
    
    func getUser(completion: @escaping (UserResponce?) -> Void) {
        fetcher.getUser { userResponce in
            completion(userResponce)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponce) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] (feed) in
            self?.feedResponce = feed
            guard let feedResponce = self?.feedResponce else { return }
            completion(self!.revealedPostIds, feedResponce)
        }
    }
    
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponce) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponce = self.feedResponce else { return }
        completion(revealedPostIds, feedResponce)
    }
    
    func getNextBatch(completion: @escaping ([Int], FeedResponce) -> Void) {
        newFromInProcess = feedResponce?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feed in
            guard let feed = feed else { return }
            guard self?.feedResponce?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponce == nil {
                self?.feedResponce = feed
            } else {
                self?.feedResponce?.items.append(contentsOf: feed.items)
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponce?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { oldProfile -> Bool in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponce?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponce?.groups {
                    let oldGroupsFiltered = oldGroups.filter { oldGroup -> Bool in
                        !feed.groups.contains(where: { $0.id == oldGroup.id })
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponce?.groups = groups

                self?.feedResponce?.nextFrom = feed.nextFrom
            }
            
            guard let feedResponce = self?.feedResponce else { return }
            completion(self!.revealedPostIds, feedResponce)
        }
    }
}
