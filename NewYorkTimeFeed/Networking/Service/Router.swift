//
//  NetworkRouter.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
  associatedtype EndPoint: EndPointType
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
  func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
  
  private var task: URLSessionTask?
  var session: URLSession
  
  init(urlSession: URLSession = .shared) {
    self.session = urlSession
  }
  
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
    do {
      let request = try self.buildRequest(from: route)
      NetworkLogger.log(request: request)
      task = self.session.dataTask(with: request, completionHandler: { data, response, error in
        completion(data, response, error)
      })
    }catch {
      completion(nil, nil, error)
    }
    self.task?.resume()
  }
  
  func cancel() {
    self.task?.cancel()
  }
  
  func buildRequest(from route: EndPoint) throws -> URLRequest {
    
    var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 10.0)
    
    request.httpMethod = route.httpMethod.rawValue
    do {
      switch route.task {
      case .request:
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
      case .requestParameters(let bodyEncoding,
                              let urlParameters):
        
        try self.configureParameters(bodyEncoding: bodyEncoding,
                                     urlParameters: urlParameters,
                                     request: &request)
      }
      return request
    } catch {
      throw error
    }
  }
  
  fileprivate func configureParameters(bodyEncoding: ParameterEncoding,
                                       urlParameters: Parameters?,
                                       request: inout URLRequest) throws {
    do {
      try bodyEncoding.encode(urlRequest: &request, urlParameters: urlParameters)
    } catch {
      throw error
    }
  }
}
