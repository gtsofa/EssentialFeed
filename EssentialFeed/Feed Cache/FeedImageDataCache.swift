//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Julius on 09/08/2022.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
