//
//  HTTPTask.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
  case request
  case requestParameters(bodyEncoding: ParameterEncoding,
                         urlParameters: Parameters?)
}
