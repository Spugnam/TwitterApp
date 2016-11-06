//
//  MenuViewController.swift
//  TwitterApp
//
//  Created by quentin picard on 11/5/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let menuOptionsTab = ["Home", "Profile", "Mentions"]
    
    private var tweetsNavigationController: UIViewController!
    private var accountNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: hamburgerViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        if User.currentUser != nil {
            print("\n There is a current user: \(User.currentUser?.name)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            tweetsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
            accountNavigationController = storyboard.instantiateViewController(withIdentifier: "AccountViewController")
            mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsViewController")
            //window?.rootViewController = vc // Ne pas mettre TweetsVC en root mais le donner a hamburger
        }
        
        viewControllers.append(tweetsNavigationController)
        viewControllers.append(accountNavigationController)
        viewControllers.append(mentionsNavigationController)
        
        hamburgerViewController.contentViewController = tweetsNavigationController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuCellLabel.text = menuOptionsTab[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
