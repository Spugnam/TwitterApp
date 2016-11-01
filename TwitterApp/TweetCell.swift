//
//  TweetCell.swift
//  TwitterApp
//
//  Created by quentin picard on 10/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            timestampLabel.text = formatter.string(from: tweet.createdAt! as Date)
            
            tweetTextLabel.text = tweet.text as String?
            username.text = tweet.user.name as String?
            profilePictureImage.setImageWith((self.tweet!.user?.profileUrl)! as URL)
            
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePictureImage.layer.cornerRadius = 3
        profilePictureImage.clipsToBounds = true
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width // Apple "bug" on wrapping
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width // Apple "bug" on wrapping
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
