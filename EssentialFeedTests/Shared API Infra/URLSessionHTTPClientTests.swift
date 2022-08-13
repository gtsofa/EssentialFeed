//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Julius on 01/05/2022.
//

import Foundation
import XCTest
import EssentialFeed

class URLSessionHTTPClientTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    
    func test_getFromURL_performsGetRequestWithURL(){
        
        let url = anyURL()
        let exp = expectation(description: "Wait for request")
        URLProtocolStub.observeRequests { requst in
            XCTAssertEqual(requst.url, url)
            XCTAssertEqual(requst.httpMethod, "GET")
            exp.fulfill()
        }
        
        makeSUT().get(from: url) { _ in }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    
    func test_cancelGetFromURLTask_cancelsURLRequest() {
        
        let receivedError = resultErrorFor(taskHandler: { $0.cancel() }) as NSError?
        
        XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
    }
    
    
    func test_getFromURL_failsOnRequestError() {
        
        let requestError = NSError(domain: "any-error", code: 1)
        let receivedError = resultErrorFor((data: nil, response: nil, error: requestError)) as NSError?
        
        XCTAssertEqual(receivedError?.domain, requestError.domain)
        XCTAssertEqual(receivedError?.code, requestError.code)
    }
    
    func test_getFromURL_failsOnAllInvalidRepresentationCases() {
        
        XCTAssertNotNil(resultErrorFor((data: nil, response: nil, error: nil)))
        XCTAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: nil)))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: nil)))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: nil, response: anyHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: nil, response: anyHTTPURLResponse(), error: anyNSError())))
        XCTAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: nil)))
        XCTAssertNotNil(resultErrorFor((data: nil, response: nil, error: anyNSError())))
       
    }
    
    func test_getFromURL_succeedsOnHTTPURLResponseWithData() {
        let data = anyData()
        let response = anyHTTPURLResponse()
        URLProtocolStub.stub(data: data, response: response, error: nil)
        
        let receivedValues = resultValueFor((data: nil, response: response, error: nil))
        
        let emptyData = Data()
        XCTAssertEqual(receivedValues?.data, emptyData)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
    }
    
    func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
        
        let response = anyHTTPURLResponse()
        let receivedValues = resultValueFor((data: nil, response: response, error: nil))
        
        let emptyData = Data()
        XCTAssertEqual(receivedValues?.data, emptyData)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
    }
    
    // MARK - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(session: session)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func resultErrorFor(_ values: (data: Data?, response: URLResponse?, error: Error?)? = nil, taskHandler: (HTTPClientTask) -> Void = { _ in },  file: StaticString = #file, line: UInt = #line) -> Error? {
        let result = resultFor(values, taskHandler: taskHandler, file: file, line: line)

        switch result {
        case let .failure(error):
            return error
            
        default:
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        }
            
    }
    
    private func resultFor(_ values: (data: Data?, response: URLResponse?, error: Error?)?, taskHandler: (HTTPClientTask) -> Void = {_ in }, file: StaticString = #file, line: UInt = #line) -> HTTPClient.Result {
        values.map {URLProtocolStub.stub(data: $0, response: $1, error: $2)}
        let sut = makeSUT(file: file, line: line)
        
        let exp = expectation(description: "wait for completion")
        
        var receivedResult: HTTPClient.Result!
        taskHandler(sut.get(from: anyURL()) { result in
            receivedResult = result
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private func resultValueFor(_ values: (data: Data?, response: URLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
        
        let result = resultFor(values, file: file, line: line)
        switch result {
        case let .success((data, response)):
            return (data, response)
            
        default:
            XCTFail("Expected success, got \(result) instead", file: file, line: line)
            return nil
        }
        
    }
    
    private func nonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
}