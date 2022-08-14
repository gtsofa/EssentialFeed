//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Julius on 02/08/2022.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
