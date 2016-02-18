//
//  Move.swift
//  TicTacToeGame
//
//  Created by Sergey on 17.02.16.
//  Copyright © 2016 greenerpastures. All rights reserved.
//

import UIKit

class Move
{
/** Property keeps tag of appropriate button */
	var tag: Int
	
/** Method composes moves array from array of button tags 
- parameter movesArray: array of buttons tags corresponding to the moves
- returns: array of user's moves*/
    class func movesFromArray( movesArray: [Int] ) -> [Move]
    {
        var moves = [Move]()
        for rawMove in movesArray {
            moves.append(Move(rawMove))
        }
        return moves
    }
    
	init( _ tag: Int )
	{
		self.tag = tag
	}
}
