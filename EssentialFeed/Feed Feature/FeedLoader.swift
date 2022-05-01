//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Julius on 18/04/2022.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
