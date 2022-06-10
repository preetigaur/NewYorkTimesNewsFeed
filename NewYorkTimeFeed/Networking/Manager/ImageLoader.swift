//
//  ImageLoader.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 10/06/22.
//

import UIKit

class ImageLoader {
  
  var task: URLSessionDownloadTask!
  var session: URLSession!
  var cache: NSCache<NSString, UIImage>!
  
  init(urlSession: URLSession = .shared) {
    session = urlSession
    task = URLSessionDownloadTask()
    self.cache = NSCache()
  }
  
  //function to download image and cache 
  func downloadImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
    if let image = self.cache.object(forKey: imagePath as NSString) {
      DispatchQueue.main.async {
        //Return cached thumbnail image
        completionHandler(image)
      }
    } else {
      
      let placeholder = #imageLiteral(resourceName: "placeholder")
      DispatchQueue.main.async {
        completionHandler(placeholder)
      }
      
      let url: URL! = URL(string: imagePath)
      task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
        
        if let data = try? Data(contentsOf: url) {
          let img: UIImage! = UIImage(data: data)
          //Cache thumbnail image
          self.cache.setObject(img, forKey: imagePath as NSString)
          DispatchQueue.main.async {
            completionHandler(img)
          }
        }
      })
      task.resume()
    }
  }
}
