//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Julius on 18/04/2022.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping(LoadFeedResult) -> Void)
}
