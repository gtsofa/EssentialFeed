//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Julius on 09/06/2022.
//

import Foundation
import EssentialFeed

public func uniqueItem() -> FeedItem {
    return FeedItem(id: UUID(), description: "any", location: "any", imageURL:  anyURL())
}

public func uniqueItems() -> (models: [FeedItem], local: [LocalFeedImage]) {
    let models = [uniqueItem(), uniqueItem()]
    
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    
    return (models, local)
}


extension Date {
    
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -feedCacheMaxAgeInDays)
    }
    
    private var feedCacheMaxAgeInDays: Int {
        return 7
    }
}
