//
//  GameViewController.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
{
	// MARK: IBOutlets
	@IBOutlet weak var whosTurnLabel: UILabel!
	@IBOutlet var buttons: [UIButton]!
	
	// MARK: Properties and instance variables
/** Flag should be set if X player's turn is first or reset otherwise*/
    var firstX = true
    
/** Flag indicating whether game should be restored from saved data */
    var restoreSavedGame = false
	
	private let xTurnString = "X's turn"
	private let oTurnString = "O's turn"

/** Flag indicates whos turn is now */
    private var _xTurn = true
	
    private var _xPlayer = Player()
	private var _oPlayer = Player()
    
/** Variable stores number of turns made by players*/
	private var _movesCounter = 0
    
    // User defaults keys
    private let xTurn_Key = "UserDefaults_xTurn"
    private let xPlayerMoves_Key = "UserDefaults_xPlayerMoves"
    private let oPlayerMoves_Key = "UserDefaults_oPlayerMoves"

	// MARK: UIViewController lifecycle methods
    deinit
    {
        // Unsubscribe from notification
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        // Add rounded corners to buttons
        for button in buttons {
            button.layer.cornerRadius = 5
        }
       
        // Restore game if needed
        if restoreSavedGame {
            
            // Check whether it was possible to restore the gsme
            if !restoreGame() {
                
                // Game restoration failed - show alert and go back
                let alert = UIAlertController(title: "Fatal error", message: "Game data is corrupted. You will not be able to proceed", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { action in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }
                    })
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
        else {
            updateTurnLabel( firstX )
        }
        
        // Subscribe to send to background notification in order to dave game state
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("saveCurrentGame"), name: UIApplicationWillResignActiveNotification, object: nil)
    }

    // MARK: IBAction methods
	@IBAction func buttonTapped( sender: UIButton )
	{
        // On button tap there is a simple fade out/in animation: 1-st part the backgroud fades out and then a mark fades in
		_movesCounter += 1
        let animationResult1 = {
            sender.backgroundColor = UIColor.whiteColor()
        }
        var animationResult2: () -> ()
		if _xTurn {
            animationResult2 = {
                sender.setImage(UIImage(named: "x-mark"), forState: .Normal)
            }
			_xPlayer.moves.append(Move(sender.tag))
			if WinningCombination.willWinWithMoves(_xPlayer.moves){
				whosTurnLabel.text = nil
				animationResult1()
                animationResult2()
                showWinAlert( "Player X" )
				return
			}
			else if _movesCounter == 9 {
				whosTurnLabel.text = nil
                animationResult1()
                animationResult2()
				showDrawAlert()
				return
			}
		}
		else {
            animationResult2 = {
                sender.setImage(UIImage(named: "o-mark"), forState: .Normal)
            }
			_oPlayer.moves.append(Move(sender.tag))
			if WinningCombination.willWinWithMoves(_oPlayer.moves){
				whosTurnLabel.text = nil
                animationResult1()
                animationResult2()
				showWinAlert( "Player O" )
				return
			}
			else if _movesCounter == 9 {
				whosTurnLabel.text = nil
                animationResult1()
                animationResult2()
				showDrawAlert()
				return
			}
		}
        
        UIView.animateWithDuration(0.1, animations: {
            sender.alpha = 0
            }) { finished in
                animationResult1()
                animationResult2()
                UIView.animateWithDuration(0.3) {
                    sender.alpha = 1
                }
        }
		
		_xTurn = !_xTurn
		sender.userInteractionEnabled = false
		updateTurnLabel( _xTurn )
	}
	
	// MARK: Other methods
	private func updateTurnLabel( xTurn: Bool )
	{
		if xTurn {
			whosTurnLabel.text = xTurnString
			_xTurn = true
		}
		else {
			whosTurnLabel.text = oTurnString
			_xTurn = false
		}
	}
	
	private func showWinAlert( player: String )
	{
		let alert = UIAlertController(title: "Congratulations!", message: player + " won", preferredStyle: .Alert )
		alert.addAction(UIAlertAction(title: "Finish", style: .Default) { action in
			dispatch_async(dispatch_get_main_queue()) {
				self.navigationController?.popToRootViewControllerAnimated( true )
			}
			})
        alert.addAction(UIAlertAction(title: "Share", style: .Default) { action in
            dispatch_async(dispatch_get_main_queue()) {
                self.shareVictory()
            }
            })
		presentViewController( alert, animated: true, completion: nil )
	}
	
	private func showDrawAlert()
	{
		let alert = UIAlertController(title: "Draw", message: nil, preferredStyle: .Alert )
		alert.addAction(UIAlertAction(title: "Finish", style: .Default) { action in
			dispatch_async(dispatch_get_main_queue()) {
				self.navigationController?.popToRootViewControllerAnimated( true )
			}
			})
		presentViewController( alert, animated: true, completion: nil )
	}
    
    func saveCurrentGame()
    {
        var gameSettings = [String: NSObject]()
        gameSettings[xTurn_Key] = _xTurn
        gameSettings[xPlayerMoves_Key] = _xPlayer.allMovesToArray()
        gameSettings[oPlayerMoves_Key] = _oPlayer.allMovesToArray()
        NSUserDefaults.standardUserDefaults().setObject(gameSettings, forKey: gameSettings_Key)
    }
    
/** Method is used to restore saved game 
- returns: true if restoration succeeded or false in case of failure 
*/
    private func restoreGame() -> Bool
    {
        // Perform all checks to make sure of data integrity
        guard let gameSettings = NSUserDefaults.standardUserDefaults().objectForKey(gameSettings_Key) as? [String: NSObject] else {return false}
        guard let xTurn = gameSettings[xTurn_Key] as? Bool else {return false}
        guard let xMoves = gameSettings[xPlayerMoves_Key] as? [Int] else {return false}
        guard let oMoves = gameSettings[oPlayerMoves_Key] as? [Int] else {return false}
        
        // Restore state
        _xTurn = xTurn
        _xPlayer = Player()
        _xPlayer.moves = Move.movesFromArray(xMoves)
        _oPlayer = Player()
        _oPlayer.moves = Move.movesFromArray(oMoves)
        
        // Restore game field
        for button in buttons {
            if let _ = xMoves.indexOf(button.tag) {
                button.setImage(UIImage(named: "x-mark"), forState: .Normal)
                button.backgroundColor = UIColor.whiteColor()
                button.userInteractionEnabled = false
            }
            else if let _ = oMoves.indexOf(button.tag) {
                button.setImage(UIImage(named: "o-mark"), forState: .Normal)
                button.backgroundColor = UIColor.whiteColor()
                button.userInteractionEnabled = false
            }
        }
        updateTurnLabel(_xTurn)
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: gameSettings_Key)
        return true
    }
    
    func shareVictory()
    {
        let shareString = "Hurray! I won TicTacToe game! Again! Now with " + (_xTurn ? "X " : "O ") + "mark."
        let controller = UIActivityViewController(activityItems: [shareString], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activity, finished, items, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
        presentViewController( controller, animated: true, completion: nil)
    }
}
