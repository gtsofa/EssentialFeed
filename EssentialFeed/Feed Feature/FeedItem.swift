//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Julius on 18/04/2022.
//

import Foundation

public struct FeedItem: Hashable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = imageURL
    }
}
