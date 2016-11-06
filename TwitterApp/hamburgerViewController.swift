//
//  hamburgerViewController.swift
//  TwitterApp
//
//  Created by quentin picard on 11/5/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class hamburgerViewController: UIViewController {
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.leadingConstraint.constant = 0
                self.view.layoutIfNeeded() 
            })

        }
    }
    

    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leadingConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            leadingConstraint.constant = originalLeftMargin + translation.x
            
        } else if sender.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.leadingConstraint.constant = self.view.frame.size.width - 200
                } else {
                    self.leadingConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
        }
        
        
    }
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    
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
