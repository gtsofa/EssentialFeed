//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Julius on 03/08/2022.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
