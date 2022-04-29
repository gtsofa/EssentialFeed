//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Julius on 18/04/2022.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
