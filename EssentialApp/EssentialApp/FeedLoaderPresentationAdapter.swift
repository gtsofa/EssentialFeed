//
//  FeedLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Julius on 09/07/2022.
//
import Combine
import EssentialFeed
import EssentialFeediOS

final class FeedLoaderPresentationAdapter{
    private let feedLoader: () -> AnyPublisher<[FeedItem], Error>
    private var cancellable: Cancellable?
    var presenter: LoadResourcePresenter<[FeedItem], FeedViewAdapter>?

    init(feedLoader: @escaping () -> AnyPublisher<[FeedItem], Error>) {
        self.feedLoader = feedLoader
    }

    func didRequestFeedRefresh() {
        presenter?.didStartLoading()
        
        cancellable = feedLoader()
            .dispatchOnMainQueue()
            .sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self?.presenter?.didFinishLoading(with: error)
                }
            }, receiveValue: { [weak self] feed in
                self?.presenter?.didFinishLoading(with: feed)
            })
    }
}
