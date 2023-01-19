//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 18.01.2023.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageURL: String?) {
        
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
        
        if let cachedResponce = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponce.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            DispatchQueue.main.async {
                if let data = data, let responce = responce {
                    self?.image = UIImage(data: data)
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
    }
}
