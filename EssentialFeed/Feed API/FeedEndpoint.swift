//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by Julius on 18/08/2022.
//

import Foundation

public enum FeedEndpoint {
    case get
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}
