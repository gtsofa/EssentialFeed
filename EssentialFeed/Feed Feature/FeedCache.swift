//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Julius on 08/08/2022.
//


public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedItem], completion: @escaping (Result) -> Void)
}
