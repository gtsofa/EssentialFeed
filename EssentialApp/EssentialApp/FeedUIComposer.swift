//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Julius on 03/07/2022.
//
import Combine
import UIKit
import EssentialFeed
import EssentialFeediOS

public final class FeedUIComposer {
    private init() {}
    
    private typealias FeedPresentationAdapter = LoadResourcePresentationAdapter<Paginated<FeedItem>, FeedViewAdapter>
    
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<Paginated<FeedItem>, Error>,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher,
        selection: @escaping (FeedItem) -> Void = { _ in }) -> ListViewController {
            let presentationAdapter = FeedPresentationAdapter(loader: feedLoader)
            
            let feedController = makeFeedViewController(title: FeedPresenter.title)
            feedController.onRefresh = presentationAdapter.loadResource
            presentationAdapter.presenter = LoadResourcePresenter(
                resourceView: FeedViewAdapter(
                    controller: feedController,
                    imageLoader: imageLoader,
                    selection: selection),
                loadingView: WeakRefVirtualProxy(feedController),
                errorView: WeakRefVirtualProxy(feedController))
            
            return feedController
        }
    
    private static func makeFeedViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
        feedController.title = title
        return feedController
    }
}

