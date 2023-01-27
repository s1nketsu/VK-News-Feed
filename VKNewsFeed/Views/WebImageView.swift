//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 18.01.2023.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }
        
        if let cachedResponce = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponce.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            DispatchQueue.main.async {
                if let data = data, let responce = responce {
                    self?.handleLoadedImage(data: data, responce: responce)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, responce: URLResponse) {
        guard let responceURL = responce.url else { return }
        let cachedResponce = CachedURLResponse(response: responce, data: data)
        URLCache.shared.storeCachedResponse(cachedResponce, for: URLRequest(url: responceURL))
        
        if responceURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}
