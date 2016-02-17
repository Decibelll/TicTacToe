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
	
	private let xTurnString = "X's turn"
	private let oTurnString = "O's turn"

/** Flag indicates whos turn is now */
    private var _xTurn = true
	
    private let _xPlayer = Player()
	private let _oPlayer = Player()
    
/** Variable stores number of turns made by players*/
	private var _movesCounter = 0

	// MARK: UIViewController lifecycle methods
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		updateTurnLabel( firstX )
		for button in buttons {
			button.layer.cornerRadius = 5
		}
    }

    // MARK: IBAction methods
	@IBAction func buttonTapped( sender: UIButton )
	{
		_movesCounter += 1
		sender.backgroundColor = UIColor.whiteColor()
		if _xTurn {
			sender.setImage(UIImage(named: "x-mark"), forState: .Normal)
			_xPlayer.moves.append(Move(sender.tag))
			if WinningCombination.willWinWithMoves(_xPlayer.moves){
				whosTurnLabel.text = nil
				showWinAlert( "Player X" )
				return
			}
			else if _movesCounter == 9 {
				whosTurnLabel.text = nil
				showDrawAlert()
				return
			}
		}
		else {
			sender.setImage(UIImage(named: "o-mark"), forState: .Normal)
			_oPlayer.moves.append(Move(sender.tag))
			if WinningCombination.willWinWithMoves(_oPlayer.moves){
				whosTurnLabel.text = nil
				showWinAlert( "Player O" )
				return
			}
			else if _movesCounter == 9 {
				whosTurnLabel.text = nil
				showDrawAlert()
				return
			}
		}
		
		_xTurn = !_xTurn
		sender.userInteractionEnabled = false
		updateTurnLabel( _xTurn )
	}
	
	// MARK: Other methods
	func updateTurnLabel( xTurn: Bool )
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
	
	func showWinAlert( player: String )
	{
		let alert = UIAlertController(title: "Congratulations!", message: player + " won", preferredStyle: .Alert )
		alert.addAction(UIAlertAction(title: "Finish", style: .Default) { action in
			dispatch_async(dispatch_get_main_queue()) {
				self.navigationController?.popToRootViewControllerAnimated( true )
			}
			})
		presentViewController( alert, animated: true, completion: nil )
	}
	
	func showDrawAlert()
	{
		let alert = UIAlertController(title: "Draw", message: nil, preferredStyle: .Alert )
		alert.addAction(UIAlertAction(title: "Finish", style: .Default) { action in
			dispatch_async(dispatch_get_main_queue()) {
				self.navigationController?.popToRootViewControllerAnimated( true )
			}
			})
		presentViewController( alert, animated: true, completion: nil )
	}
}
