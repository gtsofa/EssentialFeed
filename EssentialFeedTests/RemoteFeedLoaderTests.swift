//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Julius on 20/04/2022.
//

import Foundation
import XCTest

import EssentialFeed


class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
        
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
        
    }
    
    // MARK: - Helper
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut:RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        func get(from url: URL) {
            requestedURL = url
        
        }
    }
}
