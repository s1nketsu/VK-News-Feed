//
//  UserResponce.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 25.01.2023.
//

import Foundation

struct WelcomeUser: Codable {
    let response: [UserResponce]
}

struct UserResponce: Codable {
    let photo100: String?
}
