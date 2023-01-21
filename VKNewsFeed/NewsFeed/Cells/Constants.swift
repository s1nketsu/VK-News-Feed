//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Полищук Александр on 20.01.2023.
//

import Foundation
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 7, bottom: 10, right: 7)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 16 + Constants.topViewHeight, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    static let bottomViewWidth: CGFloat = 80
    static let bottomViewImageSize: CGFloat = 20
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    static let showMoreTextButtonInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    static let showMoreTextButtonSize = CGSize(width: 170, height: 30)
}
