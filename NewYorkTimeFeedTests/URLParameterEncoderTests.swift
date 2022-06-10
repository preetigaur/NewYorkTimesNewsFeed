//
//  NewYorkTimeFeedTests.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 09/06/22.
//

import XCTest
@testable import NewYorkTimeFeed

class URLParameterEncoderTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  // Test to
  func testURLEncoding() {
    guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?") else {
      XCTAssertTrue(false, "Could not instantiate url")
      return
    }
    var urlRequest = URLRequest(url: url)
    let parameters: Parameters = [
      "api-key": "phWiSmPz2k817GGZL3bqVYjVffwzauJK"
    ]
    
    do {
      let encoder = URLParameterEncoder()
      try encoder.encode(urlRequest: &urlRequest, with: parameters)
      guard let fullURL = urlRequest.url else {
        XCTAssertTrue(false, "urlRequest url is nil.")
        return
      }
      
      let expectedURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=phWiSmPz2k817GGZL3bqVYjVffwzauJK"
      XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
    }catch {
      
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
