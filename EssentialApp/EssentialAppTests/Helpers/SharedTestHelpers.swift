//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Julius on 08/08/2022.
//

import Foundation
import EssentialFeed

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func uniqueFeed() -> [FeedItem] {
    return [FeedItem(id: UUID(), description: "any", location: "any", imageURL: URL(string: "http://any-url.com")!)]
}
