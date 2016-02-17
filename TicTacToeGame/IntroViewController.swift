//
//  IntroViewController.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

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

