//
//  WinningCombination.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

/*
The logic behind winning cobinations is the follwing. All possible winning combinations in terms of button tags are created. Every time user does a move it is checked wether user hits the winning combination. In order to reduce the number of combinations to check every time when user does a move a prefilling operation selects only those winning combinations which contain th elast move.
*/

class WinningCombination
{
    // MARK: Properties and instance variables
	let moves: [Move]
	
    // MARK: Class methods
    
/** Method provides winning combinations for all cases 
- returns: array of all possible winning combinations
*/
	private class func allWinningCombinations() -> [WinningCombination]
	{
        // Implement all wnning combinations as a singletone object
        struct SharedInstance
        {
            static let winningCombinations: [WinningCombination] = {
                var winningCombinations = [WinningCombination]()
                
                winningCombinations.append(WinningCombination(moves: [Move(0), Move(1), Move(2)]))
                winningCombinations.append(WinningCombination(moves: [Move(3), Move(4), Move(5)]))
                winningCombinations.append(WinningCombination(moves: [Move(6), Move(7), Move(8)]))
                winningCombinations.append(WinningCombination(moves: [Move(0), Move(3), Move(6)]))
                winningCombinations.append(WinningCombination(moves: [Move(1), Move(4), Move(7)]))
                winningCombinations.append(WinningCombination(moves: [Move(2), Move(5), Move(8)]))
                winningCombinations.append(WinningCombination(moves: [Move(0), Move(4), Move(8)]))
                winningCombinations.append(WinningCombination(moves: [Move(2), Move(4), Move(6)]))
                
                return winningCombinations
            }()
        }
		
		return SharedInstance.winningCombinations
	}
	
/** Method is used to find the current state of progress of any player.
- parameter moves: array of all player's moves in the game
- returns: true if user wins with his moves or false otherwise
*/
	class func willWinWithMoves(moves: [Move]) -> Bool
	{
		// Here we make sure we have at least 3 moves for a player
		guard let lastMove = moves.last where moves.count > 2 else { return false }
		let winningCombinationsForLastMove = winningCombinationsForMove( lastMove )
		
		// The initial value is 1 because we automatically count for last move that was used for preselection of winning combinations
		var count = 1
		for combination in winningCombinationsForLastMove {
			for i in 0 ..< moves.count - 1 {
				if combination.contains(moves[i]) {
					count += 1
				}
			}
			if count == 3 {
				return true
			}
			else {
				count = 1
			}
		}
		return false
	}
	
/** Method is used to find all the winning combinations for current move.
- parameter move: last player's move
- returns: array of winning combinations selected for this particular turn
*/
	private class func winningCombinationsForMove( move: Move ) -> [WinningCombination]
	{
		var combinations = [WinningCombination]()
		for combination in allWinningCombinations() {
			if combination.contains(move) {
				combinations.append( combination )
			}
		}
		return combinations
	}
	
    // MARK: Object lifecycle methods
	init( moves: [Move] )
	{
		self.moves = moves
	}
	
    // MARK: Other methods
/** Method checks whether combination contains provided move
- parameter move: move to check
- returns: true if move is contained or false otherwise
*/
	func contains( move: Move ) -> Bool
	{
		if let _ = moves.indexOf({$0.tag == move.tag}) {
			return true
		}
		return false
	}
}
