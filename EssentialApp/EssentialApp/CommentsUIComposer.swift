//
//  CommentsUIComposer.swift
//  EssentialApp
//
//  Created by Julius on 18/08/2022.
//

import Foundation
import Combine
import UIKit
import EssentialFeed
import EssentialFeediOS

public final class CommentsUIComposer {
    private init() {}
    
    private typealias FeedPresentationAdapter = LoadResourcePresentationAdapter<[FeedItem], FeedViewAdapter>
    
    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[FeedItem], Error>) -> ListViewController {
            let presentationAdapter = FeedPresentationAdapter(loader: commentsLoader)
            
            let feedController = makeFeedViewController(title: ImageCommentsPresenter.title)
            feedController.onRefresh = presentationAdapter.loadResource
            presentationAdapter.presenter = LoadResourcePresenter(
                resourceView: FeedViewAdapter(
                    controller: feedController,
                    imageLoader: { _ in Empty<Data, Error>().eraseToAnyPublisher() }),
                loadingView: WeakRefVirtualProxy(feedController),
                errorView: WeakRefVirtualProxy(feedController),
                mapper: FeedPresenter.map)
            
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
