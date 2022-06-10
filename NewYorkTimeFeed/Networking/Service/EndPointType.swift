//
//  EndPointType.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import Foundation

protocol EndPointType {
  var baseURL : URL {get}
  var path : String {get}
  var httpMethod : HTTPMethod {get}
  var task: HTTPTask { get }
  var headers: HTTPHeaders? { get }
}
