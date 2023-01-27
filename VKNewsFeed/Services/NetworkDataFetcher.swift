//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.
//

import Foundation
import VKSdkFramework

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, responce: @escaping (FeedResponce?) -> Void)
    func getUser(responce: @escaping (UserResponce?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking!
    
    init(networking: Networking!) {
        self.networking = networking
    }
    
    func getUser(responce: @escaping (UserResponce?) -> Void) {
        guard let token = VKSdk.accessToken().accessToken else { return }
        guard let userID = VKSdk.accessToken().userId else { return }
        let allParams = ["fields":"photo_100","user_ids": userID,"access_token": token,"v": API.version]
        networking.request(path: API.user, parameters: allParams) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                responce(nil)
            } 
            let decoded = self.decodeJSON(type: WelcomeUser.self, from: data)
            responce(decoded?.response.first)
        }
    }
    
    func getFeed(nextBatchFrom: String?, responce: @escaping (FeedResponce?) -> Void) {
        guard let token = VKSdk.accessToken().accessToken else { return }
        var allParams = ["filters":"post,photo", "access_token":token, "v":API.version]
        allParams["start_from"] = nextBatchFrom
        networking.request(path: API.newsFeed, parameters: allParams) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                responce(nil)
            }
            guard let data = data else { return }
            let decoded = self.decodeJSON(type: Welcome.self, from: data)
            responce(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let responce = try? decoder.decode(type.self, from: data) else { return nil}
        return responce
    }
}
