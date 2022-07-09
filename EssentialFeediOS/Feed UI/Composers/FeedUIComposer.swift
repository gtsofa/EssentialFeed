//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Julius on 03/07/2022.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
        let refreshController = FeedRefreshViewController(delegate: presentationAdapter)
        
        let feedController = FeedViewController(refreshController: refreshController)
        feedController.title = FeedPresenter.title
        presentationAdapter.presenter = FeedPresenter(feedView: FeedViewAdapter(controller: feedController, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)), loadingView: WeakRefVirtualProxy(refreshController))
        
        return feedController
    }
}
