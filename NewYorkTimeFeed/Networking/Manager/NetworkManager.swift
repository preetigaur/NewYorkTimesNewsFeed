//
//  NetworkManager.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import Foundation

enum NetworkResponse:String {
  case success
  case authenticationError = "You need to be authenticated first."
  case badRequest = "Bad request"
  case outdated = "The url you requested is outdated."
  case failed = "Network request failed."
  case noData = "Response returned with no data to decode."
  case unableToDecode = "We could not decode the response."
  case noInternet = "Please check your network connection."
}

enum Result<String>{
  case success
  case failure(String)
}

struct NetworkManager {
  
  var session: URLSession
  var router : Router<FeedAPI>!
  static let environment : NetworkEnvironment = .production
  static let APIKey = "phWiSmPz2k817GGZL3bqVYjVffwzauJK"
  
  init(urlSession: URLSession = .shared) {
    self.session = urlSession
    self.router = Router<FeedAPI>(urlSession: session)
  }
  
  //API to get popular feeds
  func getPopularNewsFeeds(completion: @escaping (_ feeds: [NewsFeed]?,_ error: String?)->()){
    
    router.request(.popular) { data, response, error in
      
      if error != nil {
        completion(nil, NetworkResponse.noInternet.rawValue)
      } else if let response = response as? HTTPURLResponse {
        
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
          
          guard let responseData = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
          }
          do {
            let apiResponse = try JSONDecoder().decode(NewsFeedApiResponse.self, from: responseData)
            completion(apiResponse.results, nil)
          }catch {
            print(error)
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
        case .failure(let error):
          completion(nil, error)
        }
      }
    }
  }
  
  fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
  }
}
