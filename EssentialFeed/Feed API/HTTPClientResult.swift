//
//  HTTPClientResult.swift
//  EssentialFeed
//
//  Created by Julius on 30/04/2022.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping(HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
