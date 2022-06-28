//
//  HTTPClientResult.swift
//  EssentialFeed
//
//  Created by Julius on 30/04/2022.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible for dispatch to appropriate threads, if needed.
    func get(from url: URL, completion: @escaping(Result) -> Void)
}

