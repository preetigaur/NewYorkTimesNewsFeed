//
//  ImageLoaderTests.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 10/06/22.
//

import XCTest
@testable import NewYorkTimeFeed

class NetworkManagerTests: XCTestCase {
  var networkManager : NetworkManager!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    networkManager = nil
    try super.tearDownWithError()
  }
  
  func getData(name: String, withExtension: String = "json") -> Data {
    let bundle = Bundle(for: type(of: self))
    let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
    let data = try! Data(contentsOf: fileUrl!)
    return data
  }
  
  var mockJsonData: Data {
    return getData(name: "MockFeedJsonData")
  }
  
  var urlString: String {
    return "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=phWiSmPz2k817GGZL3bqVYjVffwzauJK"
  }
  
  func testGetPopularFeedsWithResults() {
    
    let mockResponse = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)!
    let mockURLSession  = MockURLSession(data: mockJsonData, urlResponse: mockResponse, error: nil)
    networkManager =  NetworkManager(urlSession: mockURLSession)
    
    let feedsExpectation = expectation(description: "feeds")
    var feedsResponse: [NewsFeed]?
    
    networkManager.getPopularNewsFeeds {feeds, error in
      if let error = error {
        XCTFail("Error: \(error)")
        return
      } else {
        feedsResponse = feeds
        feedsExpectation.fulfill()
      }
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(feedsResponse)
    }
  }
  
  func testGetPopularFeedsWithInvalidJsonReturnsError() {
    
    let invalidJsonData = "[{\"t\"}]".data(using: .utf8)

    let mockResponse = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)!
    let mockURLSession  = MockURLSession(data: invalidJsonData, urlResponse: mockResponse, error: nil)
    networkManager =  NetworkManager(urlSession: mockURLSession)
    
    let errorExpectation = expectation(description: "error")
    var errorResponse: String?
    
    networkManager.getPopularNewsFeeds {feeds, error in
      errorResponse = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(errorResponse)
    }
  }
  
  func testGetPopularFeedsWithEmptyData() {
    
    let mockResponse = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)!
    let mockURLSession  = MockURLSession(data: nil, urlResponse: mockResponse, error: nil)
    networkManager =  NetworkManager(urlSession: mockURLSession)
    
    let errorExpectation = expectation(description: "error")
    var errorResponse: String?
    
    networkManager.getPopularNewsFeeds {feeds, error in
      errorResponse = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(errorResponse)
    }
  }

    
  func testGetPopularFeedsWithError() {
    
    let error = NSError(domain: "error", code: 403, userInfo: nil)
    let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: error)
    networkManager =  NetworkManager(urlSession: mockURLSession)
  
    let errorExpectation = expectation(description: "error")
    var errorResponse: String?
    
    networkManager.getPopularNewsFeeds {feeds, error in
      errorResponse = error
      errorExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(errorResponse)
    }
  }


  
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
