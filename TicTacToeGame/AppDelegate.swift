//
//  AppDelegate.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
		return true
	}

	func applicationWillResignActive(application: UIApplication)
    {
        // Synchronize user defaults on resigning active state
		NSUserDefaults.standardUserDefaults().synchronize()
	}
}

