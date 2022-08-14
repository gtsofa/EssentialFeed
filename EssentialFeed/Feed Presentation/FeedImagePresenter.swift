//
//  FeedImagePresenter.swift
//  EssentialFeedTests
//
//  Created by Julius on 01/08/2022.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ image: FeedItem) -> FeedImageViewModel {
        
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
