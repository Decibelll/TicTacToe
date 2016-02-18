//
//  IntroViewController.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit
import iAd

// User defaults keys
let gameSettings_Key = "UserDefaults_gameSettings"

class IntroViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet var buttons: [UIButton]!
    
    // MARK: UIVIewController lifecycle methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for button in buttons {
            button.layer.cornerRadius = 5
        }
        
        // Add advertisement banner
        let banner = ADBannerView(adType: .Banner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(banner)
        var constaints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[banner]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["banner": banner])
        constaints += NSLayoutConstraint.constraintsWithVisualFormat("V:[banner]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["banner": banner])
        view.addConstraints(constaints)
        banner.addConstraint(NSLayoutConstraint(item: banner, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50))
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Check if there is saved game
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey(gameSettings_Key) {
            
            // There is a saved game - propose user to restore saved game
            let alert = UIAlertController(title: nil, message: "You have previous game saved. Do you want to continue?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .Default) { action in
                
                // User selected to restore game - instantiate game view controller and set restoreSavedGame flag
                if let gameViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GameViewController") as? GameViewController {
                    gameViewController.restoreSavedGame = true
                    dispatch_async(dispatch_get_main_queue()) {
                        self.navigationController?.pushViewController(gameViewController, animated: true)
                    }
                }
                })
            alert.addAction(UIAlertAction(title: "No", style: .Cancel) { action in
                
                // User cancelled game restoration. Delete saved game data and proceed as usual
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: gameSettings_Key)
                })
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
	// MARK: Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
        // The first turn is passed with appropriate segue. Analyze segue in order to get whos turn is first
		if segue.identifier == "StartGameO" {
			if let gameViewController = segue.destinationViewController as? GameViewController {
				gameViewController.firstX = false
			}
		}
		else if segue.identifier == "StartGameX" {
			if let gameViewController = segue.destinationViewController as? GameViewController {
				gameViewController.firstX = true
			}
		}
    }
}

