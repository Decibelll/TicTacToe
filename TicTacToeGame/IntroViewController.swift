//
//  IntroViewController.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

	// MARK: UIViewController lifecycle methods
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	// MARK: Navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
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
	
	// MARK: IBAction methods
	
}

