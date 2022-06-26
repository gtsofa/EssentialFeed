//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Julius on 18/04/2022.
//

import Foundation

public protocol FeedLoader {
    typealias  Result = Swift.Result<[FeedItem], Error>
    func load(completion: @escaping (Result) -> Void)
}
