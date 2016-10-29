//
//  loginViewController.swift
//  TwitterApp
//
//  Created by quentin picard on 10/26/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class loginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "8FIRge3ASOO0Xn9jCLBNP48Us", consumerSecret: "UJLG3HwyVByHPYkhsVgKGQsAuDsF7EvTLEJQxVhhPIWXyVXaRk")
                
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(
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
        })
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
