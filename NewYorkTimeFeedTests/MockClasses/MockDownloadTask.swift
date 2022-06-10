//
//  MockTask.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 10/06/22.
//

import Foundation

class MockDownloadTask: URLSessionDownloadTask {
  private let url: URL?
  private let urlResponse: URLResponse?
  private let _error: Error?
  
  var completionHandler: ((URL?, URLResponse?, Error?) -> Void)!
  init(url: URL?, urlResponse: URLResponse?, error: Error?) {
    self.url = url
    self.urlResponse = urlResponse
    self._error = error
  }
  override func resume() {
    DispatchQueue.main.async {
      self.completionHandler(self.url, self.urlResponse, self._error)
    }
  }
}
