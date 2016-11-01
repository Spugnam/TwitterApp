//
//  createTweetViewController.swift
//  TwitterApp
//
//  Created by quentin picard on 10/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class createTweetViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBAction func onCreateNewTweet(_ sender: Any) {
        TwitterClient.sharedInstance?.newTweet(tweet: self.tweetTextField.text!) { (tweet, error) -> Void in
            if (tweet != nil) {
                let parent = self.parent!
                parent.dismiss(animated: true, completion: {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderViewController")
                    parent.present(vc!, animated: true, completion: nil)
                })
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }
    }

    
    @IBOutlet weak var tweetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextField.becomeFirstResponder()
    
        
    }

    /*
    optional public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if ((tweetTextField.text?.characters.count)! > 139) && (!(tweetTextField.text?.isEmpty)!) {
            return true
        } else {
            return false
        }
    }// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    */
    
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
