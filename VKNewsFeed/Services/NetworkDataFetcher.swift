//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.
//

import Foundation
import VKSdkFramework

protocol DataFetcher {
    func getFeed(responce: @escaping (FeedResponce?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking!
    
    init(networking: Networking!) {
        self.networking = networking
    }
    
    func getFeed(responce: @escaping (FeedResponce?) -> Void) {
        guard let token = VKSdk.accessToken().accessToken else { return }
        let allParams = ["filters":"post,photo", "access_token":token, "v": API.version]
        networking.request(path: API.newsFeed, parameters: allParams) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                responce(nil)
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(Welcome.self, from: data)
                responce(decoded.response)
            } catch let error {
                print(error.localizedDescription)
            }
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
