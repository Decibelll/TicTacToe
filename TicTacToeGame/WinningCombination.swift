//
//  WinningCombination.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

class WinningCombination
{
	let moves: [Move]
	
	class func allWinningCombinations() -> [WinningCombination]
	{
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
	}
	
	class func willWinWithMoves(moves: [Move]) -> Bool
	{
		guard let lastMove = moves.last else { return false }
		
		let winningCombinationsForLastMove = winningCombinationsForMove( lastMove )
		var count = 0
		for combination in winningCombinationsForLastMove {
			for i in 0 ..< moves.count {
				if combination.contains(moves[i]) {
					count += 1
				}
			}
			if count == 3 {
				return true
			}
			else {
				count = 0
			}
		}
		return false
	}
	
	class func winningCombinationsForMove( move: Move ) -> [WinningCombination]
	{
		var combinations = [WinningCombination]()
		for combination in allWinningCombinations() {
			if combination.contains(move) {
				combinations.append( combination )
			}
		}
		return combinations
	}
	
	init( moves: [Move] )
	{
		self.moves = moves
	}
	
	func contains( move: Move ) -> Bool
	{
		if let _ = moves.indexOf({$0.tag == move.tag}) {
			return true
		}
		return false
	}
}
