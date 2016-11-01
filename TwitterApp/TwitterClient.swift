//
//  TwitterClient.swift
//  TwitterApp
//
//  Created by quentin picard on 10/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "vsJcghLIPCWKxWMiDsc1opDV2", consumerSecret: "SLOTNyKtMtVrPEF9rQ5oEKlC2xOLuPIsVJpZbUjdWNQKqtYr9p")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: (() -> ())?, failure: ((NSError)->())?) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(
            withPath: "oauth/request_token",
            method: "GET",
            callbackURL: URL(string: "mytwitterapp://oauth"),
            scope: nil,
            success: { (RequestToken: BDBOAuth1Credential?) in
                print("I got a token: \(RequestToken!.token!)")
                
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(RequestToken!.token!)")!
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                
            }, failure: { (error: Error?) in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error as! NSError)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            print("I got the access token!")
            
            self.currentAccount(succes: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
            })
            
            }, failure: { (error: Error?) in
                print("Access token error: \(error?.localizedDescription)")
                self.loginFailure?(error as! NSError)
        })
        
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error?) in
                failure(error as! NSError)
        })
    }
    
    func newTweet(tweet: String, completion: @escaping (_ tweet: Tweet?, _ error: NSError?) -> Void) {
        
        self.post("/1.1/statuses/update.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            print(tweet)
            completion(tweet, nil)
            
        }) { (operation: URLSessionDataTask?, error: Error) -> Void in
            print(error)
            completion(nil, error as NSError?)
        }
    }

    func currentAccount(succes: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            print(user)
            
            succes(user)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("Current Account error: \(error.localizedDescription)")
                failure(error as NSError)
        })
    }
}
