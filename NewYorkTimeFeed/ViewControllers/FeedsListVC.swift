//
//  ViewController.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 09/06/22.
//

import UIKit

class NewsFeedsListVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var spinner = UIActivityIndicatorView(style: .gray)
  let networkManager =  NetworkManager()
  let imageLoader = ImageLoader()
  var feeds : [NewsFeed] = [NewsFeed]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpView()
    fetchMostPopularFeeds()
  }
  
  func setUpView() {
    self.title = "New York Times News"
    self.tableView.register(UINib.init(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    //Add spinner to the view
    spinner.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func fetchMostPopularFeeds() {
    spinner.startAnimating()
    networkManager.getPopularNewsFeeds { feeds, error in
      DispatchQueue.main.async { [self] in
        spinner.stopAnimating()
        if (error != nil) {
          AlertUtil.showAlertMessage(self, withTitle: nil, andMessage: error)
        } else {
          self.feeds = feeds!
          self.tableView.reloadData()
        }
      }
    }
  }
}

extension NewsFeedsListVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.feeds.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell

    let feedModel : NewsFeed = feeds[indexPath.row]
    //configure cell with the feed data
    cell.configureCell(feedModel)
    
    let media : [Media] = feedModel.media.filter{$0.type == "image"}
   
    if media.count > 0 {
      let mediaMetadataList : [MediaMetadata] = media[0].mediaMetadata
      let filteredMediaMetadata : [MediaMetadata] = mediaMetadataList.filter{$0.format == "Standard Thumbnail"}
      if filteredMediaMetadata.count > 0 {
        //download thumbnail image and cache
        imageLoader.downloadImageWithPath(imagePath: filteredMediaMetadata[0].url) { (image) in
          if let updateCell = tableView.cellForRow(at: indexPath) as? FeedCell {
            updateCell.thumbnailImageView.image = image
          }
        }
      }
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let feedModel : NewsFeed = feeds[indexPath.row]
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let feedWebVC = storyboard.instantiateViewController(withIdentifier: "FeedWebVC") as! FeedWebVC
    feedWebVC.urlString = feedModel.url
    self.navigationController?.pushViewController(feedWebVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

