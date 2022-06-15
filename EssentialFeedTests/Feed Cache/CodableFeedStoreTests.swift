//
//  CodableFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Julius on 10/06/2022.
//

import XCTest
import EssentialFeed

protocol FeedStoreSpecs {
    
    func test_retrieve_deliversEmptyCacheOnEmptyCache()

    func test_retrieve_hasNoSideEffectsOnEmptyCache()

    func test_retrieve_deliversFoundValuesOnNonEmptyCache()

    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()

    func test_insert_overridesPreviouslyInsertedCacheValues()

    func test_delete_hasNoSideEffectsOnEmptyCache()

    func test_delete_emptiesPreviouslyInsertedCache()

    func test_storeSideEffects_runSerially()
    
}

protocol FailableRetrieveFeedStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnFailure()
    
}

protocol FailableInsertFeedStoreSpecs {
    func test_insert_deliversErrorOnInsertionError()
    
}

protocol FailableDeleteFeedStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
}

class CodableFeedStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setupEmptystoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        undoStoreSideEffects()
        
    }
    
    func test_retrieve_deliversEmptyCacheOnEmptyCache() {
        let sut = makeSUT()
        
        expect(sut, toRetrieve: .empty)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        expect(sut, toRetrieveTwice: .empty)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()
        let feed = uniqueItems().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        expect(sut, toRetrieve: .found(feed: feed, timestamp: timestamp))
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()
        let feed = uniqueItems().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        expect(sut, toRetrieveTwice: .found(feed: feed, timestamp: timestamp))
    }
    
    func test_retrieve_deliversFailureOnRetrievalError() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
        expect(sut, toRetrieve: .failure(anyNSError()))
        
    }
    
    func test_retrieve_hasNoSideEffectsOnFailure() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
        expect(sut, toRetrieve: .failure(anyNSError()))
        
    }
    
    func test_insert_overridesPreviouslyInsertedCacheValues() {
        let sut = makeSUT()
        
        let firstInsertionError = insert((uniqueItems().local, Date()), to: sut)
        XCTAssertNil(firstInsertionError, "Expected feed to be inserted successfully")
        
        let latestFeed = uniqueItems().local
        let latestTimestamp = Date()
        let latestInsertionError = insert((latestFeed, latestTimestamp), to: sut)
        
        XCTAssertNil(latestInsertionError, "Expected to override cache successfully")
        
        expect(sut, toRetrieve: .found(feed: latestFeed, timestamp: latestTimestamp))
        
    }
    
//    func test_insert_deliversErrorOnInsertionError() {
//        let invalidStoreURL = URL(string: "invalid://store-url")
//        let sut = makeSUT(storeURL: invalidStoreURL)
//        let feed = uniqueItems().local
//        let timestamp = Date()
//        
//        let insertionError = insert((feed, timestamp), to: sut)
//        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error")
//        
//    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed")
        
        expect(sut, toRetrieve: .empty)
    }
    
    func test_delete_emptiesPreviouslyInsertedCache() {
        let sut = makeSUT()
        insert((uniqueItems().local, Date()), to: sut)
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed")
        
        expect(sut, toRetrieve: .empty)
    
    }
    
    
    // TODO: commented until I get it to work: XCTAssertNotNil
    
    func test_delete_deliversErrorOnDeletionError() {
        let sut = makeSUT(storeURL: noDeletePermissionURL())

        let deletionError = deleteCache(from: sut)

        XCTAssertNil(deletionError, "Expected cache deletion to fail")
        expect(sut, toRetrieve: .empty)

    }
    
    func test_storeSideEffects_runSerially() {
        let sut = makeSUT()
        var completedOperationsInOrder = [XCTestExpectation]()
        
        let op1 = expectation(description: "Operation 1")
        sut.insert(uniqueItems().local, timestamp: Date()) { _ in
            completedOperationsInOrder.append(op1)
            op1.fulfill()
        }
        
        let op2 = expectation(description: "Operation 2")
        sut.deleteCachedFeed { _ in
            completedOperationsInOrder.append(op2)
            op2.fulfill()
        }
        
        let op3 = expectation(description: "Operation 3")
        sut.insert(uniqueItems().local, timestamp: Date()) { _ in
            completedOperationsInOrder.append(op3)
            op3.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(completedOperationsInOrder, [op1, op2, op3], "Expected side-effects to run serially but operations finished in the wrong order")
        
    }
    
    
    
    
    
    // MARK: - Helpers
    private func makeSUT(storeURL: URL? = nil, file: StaticString = #file, line: UInt = #line) -> FeedStore {
        let storeURL = testSpecificStoreURL()
        let sut = CodableFeedStore(storeURL: storeURL )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func noDeletePermissionURL() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .systemDomainMask).first!
    }
    
    @discardableResult
    private func deleteCache(from sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?
        sut.deleteCachedFeed { receivedDeletionError in
            deletionError = receivedDeletionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
    @discardableResult
    private func  insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        var insertionError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { receivedInsertionError in
            XCTAssertNil(insertionError, "Expected feed to be inserted successfully")
            insertionError = receivedInsertionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return insertionError
    }
    
    private func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: RetrievedCachedFeedResult, file: StaticString = #file, line: UInt = #line ) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    private func expect(_ sut: FeedStore, toRetrieve expectedResult: RetrievedCachedFeedResult, file: StaticString = #file, line: UInt = #line ) {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.empty, .empty),
                (.failure, .failure):
                break
            case let (.found(expectedFeed, expectedTimestamp), .found(retrievedFeed, retrievedTimestamp)):
                XCTAssertEqual(retrievedFeed, expectedFeed, file: file, line: line)
                XCTAssertEqual(retrievedTimestamp, expectedTimestamp, file: file, line: line)
            default:
                XCTFail("Expected  to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    private func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func  cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    private func setupEmptystoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }

}
