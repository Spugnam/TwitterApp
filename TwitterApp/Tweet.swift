//
//  Tweet.swift
//  TwitterApp
//
//  Created by quentin picard on 10/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User!
    var text: String!
    var createdAtString: String!
    var createdAt: NSDate!
    var favoritesCount: Int!
    var favorited: Bool!
    var retweetCount: Int!
    var retweeted: Bool!
    
    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as! NSDictionary)
        self.text = dictionary["text"] as? String
        self.createdAtString = dictionary["created_at"] as? String
        self.favoritesCount = dictionary["favorite_count"] as? Int
        self.favorited = dictionary["favorited"] as! Bool
        self.retweetCount = dictionary["retweet_count"] as? Int
        self.retweeted = dictionary["retweeted"] as! Bool
        
        var formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.date(from: createdAtString!) as NSDate!
        
        formatter.dateFormat = "MMM d hh:mm a"
        self.createdAtString = formatter.string(from: self.createdAt as Date)
    }
    
    
    
    
//    var text: NSString?
//    var timestamp: NSDate?
//    var retweetCount: Int = 0
//    var favoritesCount: Int = 0
//    var username: NSString?
//    var profilePictureURL: URL?
//    
//    init(dictionary: NSDictionary) {
//        text = dictionary["text"] as? NSString
//        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
//        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
//        username = dictionary["name"] as? NSString
//        
//        let profilePictureURLString = dictionary["profile_image_url_https"] as? String
//        if profilePictureURLString != nil {
//            profilePictureURL = URL(string: profilePictureURLString!)!
//        } else {
//            profilePictureURL = nil
//        }
//        
//        let timestampString = dictionary["created_at"] as? String
//        if let timestampString = timestampString {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//            timestamp = formatter.date(from: timestampString) as? NSDate
//        }
//    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}

