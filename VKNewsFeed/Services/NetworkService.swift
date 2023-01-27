//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 16.01.2023.
//

import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
        
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(from: path, parameters: parameters)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, responce, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, parameters: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
}
