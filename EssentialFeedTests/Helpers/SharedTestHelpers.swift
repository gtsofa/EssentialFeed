//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Julius on 09/06/2022.
//

import Foundation

public func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

public func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data.init(_: "any data".utf8)
}
