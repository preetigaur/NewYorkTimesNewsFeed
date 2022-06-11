//
//  NewsFeedCell.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 10/06/22.
//

import UIKit

///Custom NewsFeed UITableViewCell
class NewsFeedCell: UITableViewCell {
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var abstractLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  /**
   Configures the custom cell properties
   */
  func configureCell(_ feedModel : NewsFeed){
    titleLabel.text = feedModel.title
    authorLabel.text = feedModel.byline
    abstractLabel.text = feedModel.abstract
    dateLabel.text = feedModel.publishedDate
    self.selectionStyle = .none
  }
}
