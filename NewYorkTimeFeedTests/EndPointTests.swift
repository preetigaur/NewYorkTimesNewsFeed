//
//  EndPointTests.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 10/06/22.
//

import XCTest
@testable import NewYorkTimeFeed

class EndPointTests: XCTestCase {
  
  var router : Router<FeedAPI>!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
    router = Router<FeedAPI>()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    router = nil
    try super.tearDownWithError()
  }
  
  func testBasicRequestGeneration() {
    do {
      let request = try router.buildRequest(from: .popular)
      XCTAssertEqual(request.url, URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=phWiSmPz2k817GGZL3bqVYjVffwzauJK"))
    } catch {}
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
