//
//  NewsFeed.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import Foundation

struct NewsFeedApiResponse {
  let status : String
  let copyright : String
  let numResults : Int
  let results : [NewsFeed]
}

extension NewsFeedApiResponse : Decodable {
  private enum FeedApiResponseCodingKeys: String, CodingKey {
    case status
    case copyright
    case numResults = "num_results"
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: FeedApiResponseCodingKeys.self)
    status = try container.decode(String.self, forKey: .status)
    copyright = try container.decode(String.self, forKey: .copyright)
    numResults = try container.decode(Int.self, forKey: .numResults)
    results = try container.decode([NewsFeed].self, forKey: .results)
  }
}

struct NewsFeed {
  let abstract : String
  let byline : String
  let media : [Media]
  let publishedDate : String
  let title : String
  let url : String
}

extension NewsFeed : Decodable {
  enum FeedCodingKeys: String, CodingKey {
    case abstract
    case byline
    case media
    case publishedDate = "published_date"
    case title
    case url
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: FeedCodingKeys.self)
    
    abstract = try container.decode(String.self, forKey: .abstract)
    byline = try container.decode(String.self, forKey: .byline)
    media = try container.decode([Media].self, forKey: .media)
    publishedDate = try container.decode(String.self, forKey: .publishedDate)
    title = try container.decode(String.self, forKey: .title)
    url = try container.decode(String.self, forKey: .url)
  }
}

struct Media {
  let type : String
  let subtype : String
  let caption : String
  let copyright : String
  let approvedForSyndication : Int
  let mediaMetadata : [MediaMetadata]
}

extension Media : Decodable {
  enum FeedCodingKeys: String, CodingKey {
    case type
    case subtype
    case caption
    case copyright
    case approvedForSyndication = "approved_for_syndication"
    case mediaMetadata = "media-metadata"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: FeedCodingKeys.self)
    type = try container.decode(String.self, forKey: .type)
    subtype = try container.decode(String.self, forKey: .subtype)
    caption = try container.decode(String.self, forKey: .caption)
    copyright = try container.decode(String.self, forKey: .copyright)
    approvedForSyndication = try container.decode(Int.self, forKey: .approvedForSyndication)
    mediaMetadata = try container.decode([MediaMetadata].self, forKey: .mediaMetadata)
  }
}

struct MediaMetadata {
  let url : String
  let format : String
  let height : Int
  let width : Int
}

extension MediaMetadata : Decodable {
  enum FeedCodingKeys: String, CodingKey {
    case url
    case format
    case height
    case width
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: FeedCodingKeys.self)
    url = try container.decode(String.self, forKey: .url)
    format = try container.decode(String.self, forKey: .format)
    height = try container.decode(Int.self, forKey: .height)
    width = try container.decode(Int.self, forKey: .width)
  }
}
