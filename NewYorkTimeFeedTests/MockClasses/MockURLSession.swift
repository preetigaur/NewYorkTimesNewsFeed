//
//  MockURLSession.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 10/06/22.
//

import Foundation

class MockURLSession: URLSession {
  private let mockTask: MockTask
  private let mockDownloadTask: MockDownloadTask
  
  init(data: Data?, urlResponse: URLResponse?, error: Error?) {
    mockTask = MockTask(data: data, urlResponse: urlResponse, error:
                          error)
    mockDownloadTask = MockDownloadTask(url: nil, urlResponse: urlResponse, error:
                                  error)
  }
  
  init(url: URL?, urlResponse: URLResponse?, error: Error?) {
    mockDownloadTask = MockDownloadTask(url: url, urlResponse: urlResponse, error:
                          error)
    mockTask = MockTask(data: nil, urlResponse: urlResponse, error:
                          error)
  }
  
  override func downloadTask(with url: URL, completionHandler: @escaping ( URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
    mockDownloadTask.completionHandler = completionHandler
    return mockDownloadTask
  }
  
//  open func downloadTask(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
  
  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    mockTask.completionHandler = completionHandler
    return mockTask
  }
}



