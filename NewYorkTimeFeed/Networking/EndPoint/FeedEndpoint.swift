//
//  FeedEndpoint.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import Foundation

enum NetworkEnvironment {
  case production
}

public enum FeedAPI {
  case popular
}

extension FeedAPI: EndPointType {
  
  var environmentBaseURL : String {
    switch NetworkManager.environment {
    case .production: return "https://api.nytimes.com/"
    }
  }
  
  var baseURL: URL {
    guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
    return url
  }
  
  var path: String {
    switch self {
    case .popular:
      return "svc/mostpopular/v2/viewed/1.json"
    }
  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  var task: HTTPTask {
    switch self {
    case .popular:
      return .requestParameters(bodyEncoding: .urlEncoding,
                                urlParameters: ["api-key":NetworkManager.APIKey])
    }
  }
  
  var headers: HTTPHeaders? {
    return nil
  }
}



