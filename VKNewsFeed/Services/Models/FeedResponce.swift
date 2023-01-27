//
//  FeedResponce.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 17.01.2023.
//

import Foundation

struct Welcome: Codable {
    let response: FeedResponce
}

struct FeedResponce: Codable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
}

struct FeedItem: Codable {
    let sourceId, postId: Int
    let text: String?
    let date: Double
    let comments, likes, reposts, views: CountableItem?
    let attachments: [Attachment]?
}

struct CountableItem: Codable {
    let count: Int
}

struct Attachment: Codable {
    let photo: Photo?
}

struct Photo: Codable {
    let sizes: [Size]
    var height: Int { return getProperSize().height }
    var width: Int { return getProperSize().width }
    var srcBIG: String { return getProperSize().url }
    
    private func getProperSize() -> Size {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return Size(type: "Wrong image", url: "Wrong image", width: 0, height: 0)
        }
    }
}

struct Size: Codable {
    let type, url: String
    let width, height: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Codable, ProfileRepresentable {
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
    
    let id: Int
    let firstName, lastName, photo100: String
}

struct Group: Codable, ProfileRepresentable {
    let id: Int
    let name, photo100: String
    var photo: String { return photo100 }
}
