//
//  ImageLoaderTests.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 10/06/22.
//

import XCTest
@testable import NewYorkTimeFeed

class ImageLoaderTests: XCTestCase {
  
  var imageLoader : ImageLoader!
  
  var mockImageUrl : String {
    return "https://static01.nyt.com/images/2022/06/08/multimedia/08virus-briefing-new-omicron/08virus-briefing-new-omicron-thumbStandard.jpg"
  }
  
  var mockImageData : Data {
    return (UIImage(named: "MockImage")?.jpegData(compressionQuality: 1.0))!
  }
  
  var placeholderImage : UIImage {
    return UIImage(named: "placeholder")!
  }
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    imageLoader = nil
  }
  
  func testDownloadImageWithSuccess() {
    let mockResponse = HTTPURLResponse(url: URL(string: mockImageUrl)!, statusCode: 200,
                                       httpVersion: nil, headerFields: nil)!
    let mockURLSession  = MockURLSession(data: mockImageData, urlResponse: mockResponse, error: nil)
    
    let imageExpectation = expectation(description: "image")
    imageExpectation.assertForOverFulfill = false
    var imageResponse: UIImage?
    
    imageLoader = ImageLoader(urlSession: mockURLSession)
    imageLoader.downloadImageWithPath(imagePath: mockImageUrl) { image in
      imageResponse = image
      imageExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertNotNil(imageResponse)
    }
  }
  
  func testDownloadImageWithError() {
    let mockResponse = HTTPURLResponse(url: URL(string: mockImageUrl)!, statusCode: 403,
                                       httpVersion: nil, headerFields: nil)!
    let mockURLSession  = MockURLSession(data: nil, urlResponse: mockResponse, error: nil)
    
    let imageExpectation = expectation(description: "placeholderImage")
    imageExpectation.assertForOverFulfill = false
    var imageResponse: UIImage?
    
    imageLoader = ImageLoader(urlSession: mockURLSession)
    imageLoader.downloadImageWithPath(imagePath: mockImageUrl) { image in
      imageResponse = image
      imageExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 1) { (error) in
      XCTAssertEqual(imageResponse, self.placeholderImage)
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
