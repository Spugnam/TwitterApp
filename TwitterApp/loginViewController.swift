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
        
        TwitterClient.sharedInstance?.login(success: {
            print("I've logged in!")
            
            // Hamburger Menu
            //        let hamburgerViewController = window!.rootViewController as! hamburgerViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let hamburgerViewController = storyboard.instantiateViewController(withIdentifier: "HamburgerViewController") as! hamburgerViewController
            //window?.rootViewController = hamburgerViewController
            
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.menuViewController = menuViewController
            
//            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error: NSError) in
            print("Login error: \(error.localizedDescription)")
        }
  
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
