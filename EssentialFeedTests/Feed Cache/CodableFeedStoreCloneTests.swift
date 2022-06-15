//
//  CodableFeedStoreCloneTests.swift
//  EssentialFeedTests
//
//  Created by Julius on 16/06/2022.
//

import XCTest
import EssentialFeed

class CoddableFeedStoreClone {
    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        completion(.empty)
    }
}

class CodableFeedStoreCloneTests: XCTestCase {

    func test_retrieve_deliversEmptyOnEmptyCache(){
        let sut = CoddableFeedStoreClone()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { result in
            switch result {
            case .empty:
                break
                
            default:
                XCTFail("Expected")
            }
            exp.fulfill()
            
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache(){
        let sut = CoddableFeedStoreClone()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { firstResult in
            sut.retrieve { secondResult in
                switch (firstResult, secondResult) {
                case (.empty, .empty):
                    break
                    
                default:
                    XCTFail("Expect retrieving twice from empty cache to deliver sameempty result, got \(firstResult ) and \(secondResult) instead")
                }
                exp.fulfill()
                
            }
        }
        wait(for: [exp], timeout: 1.0)
    }

}
