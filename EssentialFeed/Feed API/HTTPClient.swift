//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Julius on 02/08/2022.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible for dispatch to appropriate threads, if needed.
    @discardableResult
    func get(from url: URL, completion: @escaping(Result) -> Void) -> HTTPClientTask
}
