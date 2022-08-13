//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Julius on 20/04/2022.
//

import Foundation

public typealias RemoteFeedLoader = RemoteLoader<[FeedItem]>

public extension RemoteFeedLoader {
    convenience init(url: URL,  client: HTTPClient) {
        self.init(url: url, client: client, mapper: FeedItemsMapper.map)
    }
}


