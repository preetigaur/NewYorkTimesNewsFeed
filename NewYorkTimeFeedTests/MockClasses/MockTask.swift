//
//  MockTask.swift
//  NewYorkTimeFeedTests
//
//  Created by Preeti Gaur on 10/06/22.
//

import Foundation

class MockTask: URLSessionDataTask {
  private let data: Data?
  private let urlResponse: URLResponse?
  private let _error: Error?
  
  var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
  init(data: Data?, urlResponse: URLResponse?, error: Error?) {
    self.data = data
    self.urlResponse = urlResponse
    self._error = error
  }
  override func resume() {
    DispatchQueue.main.async {
      self.completionHandler(self.data, self.urlResponse, self._error)
    }
  }
}
